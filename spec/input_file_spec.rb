require_relative '../input_file'

RSpec.describe InputFile do
  let(:input_file_location_path) { 'spec/fixtures/scenario_1.txt' }
  let(:input_file) { InputFile.new(input_file_location_path) }

  describe 'attributes' do
    it { expect(input_file).to respond_to(:commands) }
    it { expect(input_file.commands).not_to be_empty }
    it { expect(input_file.commands).to be_a(Array) }
    it { expect(input_file.commands.size).to eql(3) }
    it { expect(input_file.commands.first.keys).to eql([:command, :position_x, :position_y, :facing]) }
    it { expect(input_file.commands[1].keys).to eql([:command]) }
    it { expect(input_file.commands[1].keys).not_to include(:position_y) }
    it { expect(input_file.commands[1].keys).not_to include(:position_x) }
    it { expect(input_file.commands[1].keys).not_to include(:facing) }
  end
end