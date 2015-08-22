module RealWorldRails
  module Inspectors

    class ModelMethodsInspector < Inspector

      inspects :models

      class Processor < BaseProcessor
        def on_def(node)
          expression = node.location.expression
          filename = expression.source_buffer.name
          puts formatted_filename(filename)
          puts expression.source
          puts "\n"
        end
      end

    end

  end
end
