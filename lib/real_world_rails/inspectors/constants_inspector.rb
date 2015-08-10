require_relative 'file_inspector'

module RealWorldRails
  module Inspectors

    class ConstantsInspector
      def run
        parser = ParserFactory.create
        files = Dir.glob("apps/**/*.rb")
        processor = Processor.new
        files.each do |filename|
          if inspectable?(filename)
            buffer = Parser::Source::Buffer.new filename
            buffer.read
            ast = parser.reset.parse(buffer)
            processor.process(ast)
          end
        end
      end

      def inspectable?(filename)
        !FileInspector.from_gem?(filename) && !FileInspector.test?(filename) && !FileInspector.from_generator?(filename)
      end
    end

    class Processor < Parser::AST::Processor

      # on_casgn: on constant assignment
      def on_casgn(node)
        expression = node.location.expression
        filename = expression.source_buffer.name
        puts "File: #{filename}"
        puts expression.source
      end

    end

  end
end
