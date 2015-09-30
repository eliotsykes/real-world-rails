module RealWorldRails
  class FilenameSpecification
    attr_accessor :includes, :excludes

    MODEL_FILENAMES_REGEX = %r{\A.+/models/.+\.rb\z}
    VIEW_FILENAMES_REGEX = %r{\Aapps/(?!.*/(spec|test|gems)/).*app/views/.+\z}
    GENERATOR_FILENAMES_REGEX = %r{\A.+/lib/(.+/)?generators/}
    TEST_FILENAMES_REGEX = %r{_(test)\.rb\z}
    SPEC_FILENAMES_REGEX = %r{_(spec)\.rb\z}
    GEM_FILENAMES_REGEX = %r{canvas-lms/gems/}

    ALIASED_REGEXES = {
      models: MODEL_FILENAMES_REGEX,
      specs: SPEC_FILENAMES_REGEX,
      tests: TEST_FILENAMES_REGEX,
      generators: GENERATOR_FILENAMES_REGEX,
      gems: GEM_FILENAMES_REGEX
    }

    VALID_REGEX_ALIASES = ALIASED_REGEXES.keys.freeze

    def self.build(*specifications, except:[])
      if [:views] == specifications
        # The views regex is precise and does not benefit from the excludes.
        filename_specification = self.new(only: VIEW_FILENAMES_REGEX)
      else
        filename_specification = self.new(*specifications, except: except)
      end
      filename_specification
    end

    def initialize(*specifications, except: [], only: nil)
      if !only.nil?
        raise ArgumentError, "`only:` limited to Regexps (for now)" unless only.is_a? Regexp
        self.includes = [only]
        self.excludes = []
      else
        specifications.delete(:all)
        aliases = (specifications + except).delete_if { |option| option.is_a?(Regexp) }
        assert_valid_aliases(aliases)

        self.includes = specifications.map { |spec| ALIASED_REGEXES[spec] || spec }

        if except.empty?
          except = ALIASED_REGEXES.keys - specifications
        end

        self.excludes = except.map { |spec| ALIASED_REGEXES[spec] || spec }
      end
    end

    def satisfied_by?(filename)
      !excluded?(filename) && included?(filename)
    end

    private

    def assert_valid_aliases(aliases)
      unknown_aliases = aliases - VALID_REGEX_ALIASES
      if unknown_aliases.any?
        raise ArgumentError, "Unknown specification aliases: '#{unknown_aliases}'"
      end
    end

    def excluded?(filename)
      excludes.any? { |spec| filename.match(spec) }
    end

    def included?(filename)
      includes.all? { |spec| filename.match(spec) }
    end
  end
end
