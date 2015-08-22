module RealWorldRails
  module Inspectors

    class ConstantsInspector < Inspector

      inspects :all, except: [:gems, :tests, :specs, :generators]

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
end
