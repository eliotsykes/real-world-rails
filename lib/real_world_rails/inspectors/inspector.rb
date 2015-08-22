require_relative '../specifications/filename_specification'

module RealWorldRails
  module Inspectors
    class Inspector

      class << self
        attr_accessor :filename_specification
      end

      def self.inspects(*specifications)
        self.filename_specification = Specifications::FilenameSpecification.new(*specifications)
      end

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

    end
  end
end
