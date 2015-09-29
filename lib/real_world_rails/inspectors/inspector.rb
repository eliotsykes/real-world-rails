require 'coderay'
require_relative '../printer'
require_relative '../filename_specification'

module RealWorldRails
  module Inspectors
    class Inspector
      include Printer

      class << self
        attr_accessor :filename_specification
      end

      def self.inspects(*specifications)
        self.filename_specification = FilenameSpecification.build(*specifications)
      end

      def run
        before_inspect_files
        inspect_files
        after_inspect_files
      end

      # Before Hook
      def before_inspect_files
      end

      def inspect_files
        filenames.each { |filename| inspect_file(filename) }
      end

      # After Hook
      def after_inspect_files
      end

      def filenames
        glob_pattern = ENV.fetch('FILES_PATTERN', files_pattern)
        Dir.glob(glob_pattern).select { |filename| inspectable?(filename) }
      end

      def files_pattern
        "apps/**/*.rb"
      end

      def inspectable?(filename)
        File.file?(filename) && self.class.filename_specification.satisfied_by?(filename)
      end

      def inspect_file(filename)
        buffer = create_buffer(filename)
        ast = parser.reset.parse(buffer)
        processor.process(ast)
      end

      def create_buffer(filename)
        Parser::Source::Buffer.new(filename).read
      end

      def parser
        @parser ||= ParserFactory.create
      end

      def processor
        @processor ||= create_processor
      end

      def create_processor
        processor_class_name = "#{self.class}::Processor"
        processor_class = Object.const_get processor_class_name
        processor_class.new
      end

      class BaseProcessor < Parser::AST::Processor
        include Printer
      end

    end
  end
end
