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
    end

  end
end
