require 'real_world_rails/filename_specification'

module RealWorldRails
  describe FilenameSpecification do

    context :views do
      it 'is satisfied by view templates' do
        filename_specification = FilenameSpecification.build :views
        expect(filename_specification.satisfied_by?('apps/foo/app/views/bar/index.html.erb')).to eq true
      end

      it 'is not satisfied by view specs' do
        filename_specification = FilenameSpecification.build :views
        expect(filename_specification.satisfied_by?('apps/foo/spec/something/app/views/bar_spec.rb')).to eq false
      end

      it 'is not satisfied by view tests' do
        filename_specification = FilenameSpecification.build :views
        expect(filename_specification.satisfied_by?('apps/foo/test/something/app/views/bar_spec.rb')).to eq false
      end

      it 'is not satisfied by gems' do
        filename_specification = FilenameSpecification.build :views

        expect(filename_specification.satisfied_by?(
          'apps/canvas-lms/gems/plugins/qti_exporter/app/views/plugins/_qti_converter_settings.html.erb'
        )).to eq false

        expect(filename_specification.satisfied_by?(
          'apps/open-data-certificate/vendor/gems/surveyor-1.4.0/app/views/partials/_answer.html.haml'
        )).to eq false
      end

      it 'is not satified by dummy app views' do
        filename_specification = FilenameSpecification.build :views

        expect(filename_specification.satisfied_by?(
          'apps/spina/test/dummy/app/views/default/pages/homepage.html.erb'
        )).to eq false
      end
    end

  end
end
