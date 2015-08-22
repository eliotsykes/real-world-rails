module RealWorldRails
  module Printer
    def formatted_filename(filename)
      "File: #{filename}"
    end

    def pretty_print_source(source)
      puts CodeRay::Duo[:ruby, :terminal].highlight(source)
    end
  end
end
