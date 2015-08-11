# require 'pp'
# require 'pry'

# Much of this script borrowed from:
# https://github.com/whitequark/parser/blob/master/lib/parser/runner.rb and friends

module RealWorldRails
  module Inspectors

    class ModelsInspector
      def run
        parser = ParserFactory.create
        files = Dir.glob("**/models/**/*.rb")
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
        true
      end

      class Processor < Parser::AST::Processor
        def on_class(node)
          # binding.pry
          # pp node.inspect
          class_name = node.children.first.children.last
          puts class_name
        end
      end
    end

  end
end
