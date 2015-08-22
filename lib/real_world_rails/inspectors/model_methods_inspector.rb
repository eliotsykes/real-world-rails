module RealWorldRails
  module Inspectors

    class ModelMethodsInspector < Inspector

      inspects :models

      class Processor < BaseProcessor
        def on_def(node)
          expression = node.location.expression
          filename = expression.source_buffer.name
          pretty_print_source source: expression.source, filename: filename
          puts
        end
      end

    end

  end
end
