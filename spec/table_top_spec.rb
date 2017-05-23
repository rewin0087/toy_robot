require_relative '../lib/table_top'
require_relative '../lib/toy_robot'

RSpec.describe TableTop do
  let(:table_top) { TableTop.new('spec/fixtures/scenario_1.txt') }

  describe 'attributes' do
    it { expect(table_top).to respond_to(:dimensions) }
    it { expect(table_top).to respond_to(:commands) }
    it { expect(table_top).to respond_to(:toy_robot) }
    it { expect(table_top).to respond_to(:input_file_location) }
    it { expect(table_top.dimensions).to be_a(Hash) }
    it { expect(table_top.dimensions.keys).to eql([:x, :y]) }
    it { expect(table_top.dimensions).to eql({ x: 5, y: 5 }) }
    it { expect(table_top.commands).to be_a(Array) }
    it { expect(table_top.commands).to be_empty }
    it { expect(table_top.toy_robot).to be_nil }
    it { expect(table_top.input_file_location).to be_a(String) }
    it { expect(table_top.input_file_location).to eql('spec/fixtures/scenario_1.txt') }
    it { expect(table_top.toy_robot_current_position).to be_nil }
  end

  describe '#place_toy_robot_and_execute' do
    context 'Scenario 1 - When a normal sequence of command has been invoke' do
      before { table_top.place_toy_robot_and_execute }

      it { expect(table_top.commands).to be_a(Array) }
      it { expect(table_top.commands).not_to be_empty }
      it { expect(table_top.commands.size).to eql(2) }
      it { expect(table_top.dimensions).not_to be_empty }
      it { expect(table_top.dimensions).to be_a(Hash) }
      it { expect(table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(table_top.toy_robot).not_to be_nil }
      it { expect(table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(table_top.toy_robot_current_position).to be_a(String) }
      it { expect(table_top.toy_robot_current_position).not_to be_empty }
      it { expect(table_top.toy_robot_current_position).to eql('0,1,NORTH') }
    end

    context 'Scenario 2 - When a normal sequence of command has been invoke' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_2.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(2) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).not_to be_nil }
      it { expect(new_table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(new_table_top.toy_robot_current_position).to be_a(String) }
      it { expect(new_table_top.toy_robot_current_position).not_to be_empty }
      it { expect(new_table_top.toy_robot_current_position).to eql('0,0,WEST') }
    end

    context 'Scenario 3 - When a normal sequence of command has been invoke' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_3.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(5) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).not_to be_nil }
      it { expect(new_table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(new_table_top.toy_robot_current_position).to be_a(String) }
      it { expect(new_table_top.toy_robot_current_position).not_to be_empty }
      it { expect(new_table_top.toy_robot_current_position).to eql('3,3,NORTH') }
    end

    context 'Scenario 4 - When no PLACE command invoke in the start and a PLACE command was invoke in the middle of the execution' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_4.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(6) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).not_to be_nil }
      it { expect(new_table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(new_table_top.toy_robot_current_position).to be_a(String) }
      it { expect(new_table_top.toy_robot_current_position).not_to be_empty }
      it { expect(new_table_top.toy_robot_current_position).to eql('2,2,EAST') }
    end

    context 'Scenario 5 - When no PLACE command invoke in the start and 2 PLACE commands was invoke in the middle of execution' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_5.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(10) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).not_to be_nil }
      it { expect(new_table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(new_table_top.toy_robot_current_position).to be_a(String) }
      it { expect(new_table_top.toy_robot_current_position).not_to be_empty }
      it { expect(new_table_top.toy_robot_current_position).to eql('2,1,EAST') }
    end

    context 'Scenario 6 - With no report invoke and no PLACE command was invoke in the start' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_6.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(5) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).not_to be_nil }
      it { expect(new_table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(new_table_top.toy_robot_current_position).to be_nil }
      it { expect(new_table_top.toy_robot_current_position).not_to be_a(String) }
    end

    context 'Scenario 7 - With unidentified commands has been included in the execution' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_7.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(3) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).not_to be_nil }
      it { expect(new_table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(new_table_top.toy_robot_current_position).to be_a(String) }
      it { expect(new_table_top.toy_robot_current_position).not_to be_empty }
      it { expect(new_table_top.toy_robot_current_position).to eql('0,2,SOUTH') }
    end

    context 'Scenario 8 - When unidentified commands has been included after the first PLACE command in the execution' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_8.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(4) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).not_to be_nil }
      it { expect(new_table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(new_table_top.toy_robot_current_position).to be_a(String) }
      it { expect(new_table_top.toy_robot_current_position).not_to be_empty }
      it { expect(new_table_top.toy_robot_current_position).to eql('0,2,SOUTH') }
    end

    context 'Scenario 9 - When PLACE command is invalid and no other next PLACE command found' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_9.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(5) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).to be_nil }
      it { expect(new_table_top.toy_robot_current_position).to be_nil }
    end

    context 'Scenario 10 - When first PLACE command is invalid and found another 2 valid PLACE commands' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_10.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(4) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).not_to be_nil }
      it { expect(new_table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(new_table_top.toy_robot_current_position).to be_a(String) }
      it { expect(new_table_top.toy_robot_current_position).not_to be_empty }
      it { expect(new_table_top.toy_robot_current_position).to eql('3,2,EAST') }
    end

    context 'Scenario 11 - When first PLACE command is invalid and its x and y position are out of bound and found another valid PLACE commands' do
      let(:new_table_top) { TableTop.new('spec/fixtures/scenario_11.txt') }
      before { new_table_top.place_toy_robot_and_execute }

      it { expect(new_table_top.commands).to be_a(Array) }
      it { expect(new_table_top.commands).not_to be_empty }
      it { expect(new_table_top.commands.size).to eql(6) }
      it { expect(new_table_top.dimensions).not_to be_empty }
      it { expect(new_table_top.dimensions).to be_a(Hash) }
      it { expect(new_table_top.dimensions).to eql({ x: 5, y: 5 }) }
      it { expect(new_table_top.toy_robot).not_to be_nil }
      it { expect(new_table_top.toy_robot).to be_a(ToyRobot) }
      it { expect(new_table_top.toy_robot_current_position).to be_a(String) }
      it { expect(new_table_top.toy_robot_current_position).not_to be_empty }
      it { expect(new_table_top.toy_robot_current_position).to eql('3,1,EAST') }
    end
  end
end