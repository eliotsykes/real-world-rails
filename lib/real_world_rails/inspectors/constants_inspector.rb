module RealWorldRails
  module Inspectors

    class ConstantsInspector < Inspector

      inspects :all, except: [:gems, :tests, :specs, :generators]

      class Processor < BaseProcessor

        # on_casgn: on constant assignment
        def on_casgn(node)
          expression = node.location.expression
          filename = expression.source_buffer.name
          pretty_print_source source: expression.source, filename: filename
          puts
        end

      end

    end


  end
end
