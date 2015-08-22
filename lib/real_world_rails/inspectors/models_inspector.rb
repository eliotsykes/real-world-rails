module RealWorldRails
  module Inspectors

    class ModelsInspector < Inspector

      inspects :models

      class Processor < BaseProcessor
        def on_class(node)
          class_name = node.children.first.children.last
          puts class_name
        end
      end

    end

  end
end
