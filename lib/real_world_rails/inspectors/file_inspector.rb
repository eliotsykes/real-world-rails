module RealWorldRails
  module Inspectors

    class FileInspector
      def self.from_gem?(filename)
        filename.start_with? "apps/canvas-lms/gems/"
      end

      TEST_REGEX = /_(?:spec|test)\.rb$/

      def self.test?(filename)
        filename.match TEST_REGEX
      end

      GENERATOR_REGEX = %r{\Aapps/.+/lib/(?:.+/)?generators/}

      def self.from_generator?(filename)
        filename.match GENERATOR_REGEX
      end

    end

  end
end
