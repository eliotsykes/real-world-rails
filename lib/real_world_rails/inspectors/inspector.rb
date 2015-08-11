module RealWorldRails
  module Inspectors
    class Inspector

      def run
        parser = ParserFactory.create
        files = Dir.glob files_pattern
        processor = create_processor
        files.each do |filename|
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

      def files_pattern
        "apps/**/*.rb"
      end

      def inspectable?(filename)
        true
      end

    end
  end
end
