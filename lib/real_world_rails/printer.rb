module RealWorldRails
  module Printer

    SOURCE_OUTPUT_FORMAT_DEFAULT = :terminal
    LANGUAGE = :ruby
    MARKDOWN_CODE_FENCE = '```'.freeze

    def formatted_filename(filename)
      "File: #{filename}"
    end

    def pretty_print_source(source:, filename: nil)
      if output_markdown?
        puts "#{MARKDOWN_CODE_FENCE}#{LANGUAGE}"
        puts "# #{formatted_filename(filename)}"
        puts source
        puts MARKDOWN_CODE_FENCE
      else
        puts formatted_filename(filename)
        puts CodeRay::Duo[LANGUAGE, source_output_format].highlight(source)
      end
    end

    private

    MARKDOWN_FORMATS = [:md, :markdown]

    def output_markdown?
      MARKDOWN_FORMATS.include? source_output_format
    end

    def source_output_format
      @source_output_format ||= ENV.fetch("SOURCE_OUTPUT_FORMAT", SOURCE_OUTPUT_FORMAT_DEFAULT).to_sym
    end
  end
end
