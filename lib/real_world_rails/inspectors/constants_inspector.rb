module RealWorldRails
  module Inspectors

    class ConstantsInspector
      def run
        parser = ParserFactory.create
        # files = Dir.glob("apps/**/*.rb")
        files = Dir.glob("apps/24pullrequests/**/*.rb")
        processor = Processor.new
        files.each do |filename|
          source = File.read(filename)
          buffer = Parser::Source::Buffer.new filename
          buffer.source = source
          parser.reset
          ast = parser.parse(buffer)
          puts filename
          processor.process(ast)
        end
      end
    end

    class Processor < Parser::AST::Processor
      def on_const(node)
        # require 'pry'
        # require 'pp'
        # binding.pry
        # class_name = node.children.first.children.last
        if node.children.last =~ /^[A-Z]+$/
          puts node.inspect
        end
      end
    end

  end
end
