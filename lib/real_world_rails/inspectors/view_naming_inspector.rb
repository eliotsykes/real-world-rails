require 'tty'

module RealWorldRails
  module Inspectors

    class ViewNamingInspector < Inspector

      inspects :views

      def files_pattern
        "apps/**/*"
      end

      def inspect_file(filename)
        ViewTemplate.add filename
      end

      def after_inspect_files
        ViewTemplate.report
      end

      class ViewTemplate

        @@store = []

        def self.add(filename)
          @@store << filename
        end

        def self.report
          analyze_view_directories
        end

        def self.analyze_view_directories

          view_dirs = Set.new
          prevent_devise_skewing_report = true
          devise_directory = '/devise/'

          @@store.each do |view_filename|
            if prevent_devise_skewing_report
              next if view_filename.include?(devise_directory)
            end

            view_dir = File.dirname(view_filename)
            view_dirs << view_dir
          end

          view_home_regex = %r{.+/app/views/}
          frequencies = Hash.new(0)

          view_dirs.each do |view_dir|
            relative_view_dir = view_dir.sub(view_home_regex, '')
            frequencies[relative_view_dir] += 1
          end

          headers = ['Frequency', 'View Directory']
          rows = frequencies.sort_by {|view_dir, freq| -freq}.map {|view_dir, freq| [freq, view_dir]}
          table = TTY::Table.new headers, rows

          puts table.render(:unicode, alignments: [:right, :left])
        end

      end
    end

  end
end
