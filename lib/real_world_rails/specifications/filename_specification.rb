module RealWorldRails
  module Specifications
    class FilenameSpecification

      attr_accessor :includes, :excludes

      ALL_FILENAMES_REGEX = %r{.+}
      MODEL_FILENAMES_REGEX = %r{\A.+/models/.+\.rb\z}
      GENERATOR_FILENAMES_REGEX = %r{\A.+/lib/(.+/)?generators/}
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
