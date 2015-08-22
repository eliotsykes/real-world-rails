module RealWorldRails
  module Inspectors

    class ModelMethodNamesInspector < Inspector

      inspects :models

      class Processor < BaseProcessor
        def on_def(node)
          method_name = node.children.first
          expression = node.location.expression
          filename = expression.source_buffer.name
          puts "#{method_name} (#{filename})"
        end
      end

    end

  end
end
