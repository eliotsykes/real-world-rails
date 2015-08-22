module RealWorldRails
  module Inspectors

    class ModelMethodsInspector < Inspector

      inspects :models

      class Processor < Parser::AST::Processor
        def on_def(node)
          expression = node.location.expression
          filename = expression.source_buffer.name
          puts "File: #{filename}"
          puts expression.source
          puts "\n"
        end
      end

    end

  end
end
