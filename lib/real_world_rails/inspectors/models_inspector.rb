# require 'pp'
# require 'pry'

# Much of this script borrowed from:
# https://github.com/whitequark/parser/blob/master/lib/parser/runner.rb and friends

module RealWorldRails
  module Inspectors

    class ModelsInspector
      def run
        parser = ParserFactory.create
        model_files = Dir.glob("**/models/**/*.rb")
        processor = Processor.new
        model_files.each do |filename|
          # filename = "apps/trailmix/app/models/subscription.rb"
          source = File.read(filename)
          buffer = Parser::Source::Buffer.new filename
          buffer.source = source
          parser.reset
          ast = parser.parse(buffer)
          processor.process(ast)
        end
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
