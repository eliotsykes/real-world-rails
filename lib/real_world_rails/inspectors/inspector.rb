module RealWorldRails
  module Inspectors
    class Inspector

      def run
        parser = ParserFactory.create
        processor = create_processor
        filenames.each do |filename|
          if inspectable?(filename)
            buffer = Parser::Source::Buffer.new filename
            buffer.read
            ast = parser.reset.parse(buffer)
            processor.process(ast)
          end
        end
      end

      def create_processor
        processor_class_name = "#{self.class}::Processor"
        processor_class = Object.const_get processor_class_name
        processor_class.new
      end

      def filenames
        Dir.glob ENV.fetch('FILES_PATTERN', files_pattern)
      end

      def files_pattern
        "apps/**/*.rb"
      end

      def inspectable?(filename)
        self.class.filename_specification.satisfied_by? filename
      end

      class << self
        attr_accessor :filename_specification
      end

      def self.inspects(*specifications)
        self.filename_specification = FilenameSpecification.new(*specifications)
      end

      class FilenameSpecification

        attr_accessor :includes, :excludes

        ALL_FILENAMES_REGEX = %r{.+}
        MODEL_FILENAMES_REGEX = %r{\Aapps/.+/models/.+\.rb\z}
        GENERATOR_FILENAMES_REGEX = %r{\Aapps/.+/lib/(.+/)?generators/}
        TEST_FILENAMES_REGEX = %r{_(test)\.rb\z}
        SPEC_FILENAMES_REGEX = %r{_(spec)\.rb\z}
        GEM_FILENAMES_REGEX = %r{canvas-lms/gems/}

        ALIASED_REGEXES = {
          all: ALL_FILENAMES_REGEX,
          models: MODEL_FILENAMES_REGEX,
          specs: SPEC_FILENAMES_REGEX,
          tests: TEST_FILENAMES_REGEX,
          generators: GENERATOR_FILENAMES_REGEX,
          gems: GEM_FILENAMES_REGEX
        }

        def initialize(*specifications, except:[])
          self.includes = specifications.map { |spec| ALIASED_REGEXES[spec] }

          if except.empty?
            except = ALIASED_REGEXES.keys - [:all] - specifications
          end

          self.excludes = except.map { |spec| ALIASED_REGEXES[spec] }
        end

        def satisfied_by?(filename)
          !excluded?(filename) && included?(filename)
        end

        private

        def excluded?(filename)
          excludes.any? { |spec| filename.match(spec) }
        end

        def included?(filename)
          includes.all? { |spec| filename.match(spec) }
        end
      end

    end
  end
end
