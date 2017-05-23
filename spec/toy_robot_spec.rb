require_relative '../toy_robot'

RSpec.describe ToyRobot do
  let(:commands) do
    [
      { command: 'MOVE' },
      { command: 'MOVE' },
      { command: 'LEFT' },
      { command: 'MOVE' },
      { command: 'RIGHT' },
      { command: 'MOVE' },
      { command: 'REPORT' }
    ]
  end

  let(:toy_robot) { ToyRobot.new(0,0, 'NORTH', { x: 5, y: 5 }, commands) }

  describe 'constants' do
    it { expect(ToyRobot::COMPASS).to eql(['NORTH', 'SOUTH', 'WEST', 'EAST']) }
    it { expect(ToyRobot::ACTIONS).to eql(['LEFT', 'RIGHT', 'MOVE', 'REPORT', 'PLACE']) }
  end

  describe 'class_methods' do
    context '.validate_command' do
      it { expect(ToyRobot.validate_command('LEFT')).to eql({ command: 'LEFT' }) }
      it { expect(ToyRobot.validate_command('RIGHT')).to eql({ command: 'RIGHT' }) }
      it { expect(ToyRobot.validate_command('PLACE 0,2,NORTH')).to eql({ command: 'PLACE', position_x: 0, position_y: 2, facing: 'NORTH' }) }
      it { expect(ToyRobot.validate_command('MOVE')).to eql({ command: 'MOVE' }) }
      it { expect(ToyRobot.validate_command('REPORT')).to eql({ command: 'REPORT' }) }
      it { expect(ToyRobot.validate_command('TEST')).to be_nil }
    end

    context '.north' do
      it { expect(ToyRobot.north).to eql('NORTH') }
      it { expect(ToyRobot.north).to be_a(String) }
      it { expect(ToyRobot.north).not_to be_nil }
    end

    context '.south' do
      it { expect(ToyRobot.south).to eql('SOUTH') }
      it { expect(ToyRobot.south).to be_a(String) }
      it { expect(ToyRobot.south).not_to be_nil }
    end

    context '.west' do
      it { expect(ToyRobot.west).to eql('WEST') }
      it { expect(ToyRobot.west).to be_a(String) }
      it { expect(ToyRobot.west).not_to be_nil }
    end

    context '.east' do
      it { expect(ToyRobot.east).to eql('EAST') }
      it { expect(ToyRobot.east).to be_a(String) }
      it { expect(ToyRobot.east).not_to be_nil }
    end

    context '.left' do
      it { expect(ToyRobot.left).to eql('LEFT') }
      it { expect(ToyRobot.left).to be_a(String) }
      it { expect(ToyRobot.left).not_to be_nil }
    end

    context '.right' do
      it { expect(ToyRobot.right).to eql('RIGHT') }
      it { expect(ToyRobot.right).to be_a(String) }
      it { expect(ToyRobot.right).not_to be_nil }
    end

    context '.move' do
      it { expect(ToyRobot.move).to eql('MOVE') }
      it { expect(ToyRobot.move).to be_a(String) }
      it { expect(ToyRobot.move).not_to be_nil }
    end

    context '.report' do
      it { expect(ToyRobot.report).to eql('REPORT') }
      it { expect(ToyRobot.report).to be_a(String) }
      it { expect(ToyRobot.report).not_to be_nil }
    end

    context '.place' do
      it { expect(ToyRobot.place).to eql('PLACE') }
      it { expect(ToyRobot.place).to be_a(String) }
      it { expect(ToyRobot.place).not_to be_nil }
    end
  end

  describe 'attributes' do
    it { expect(toy_robot).to respond_to(:current_position_x) }
    it { expect(toy_robot).to respond_to(:current_position_y) }
    it { expect(toy_robot).to respond_to(:current_facing_direction) }
    it { expect(toy_robot).to respond_to(:table_dimensions) }
    it { expect(toy_robot).to respond_to(:commands) }
    it { expect(toy_robot).to respond_to(:movement_history) }
    it { expect(toy_robot).to respond_to(:output) }
    it { expect(toy_robot.current_position_x).to be_a(Fixnum) }
    it { expect(toy_robot.current_position_x).to eql(0) }
    it { expect(toy_robot.current_position_y).to be_a(Fixnum) }
    it { expect(toy_robot.current_position_y).to eql(0) }
    it { expect(toy_robot.current_facing_direction).to be_a(String) }
    it { expect(toy_robot.current_facing_direction).to eql('NORTH') }
    it { expect(toy_robot.table_dimensions).to eql({ x: 5, y: 5 }) }
    it { expect(toy_robot.commands).to eql(commands) }
  end

  describe '#methods' do
    context '#execute_commands' do
      before { toy_robot.execute_commands }

      it { expect(toy_robot.current_position_y).to eql(3) }
      it { expect(toy_robot.current_position_x).to eql(0) }
      it { expect(toy_robot.current_facing_direction).to eql('NORTH') }
      it { expect(toy_robot.commands.size).to eql(7) }
      it { expect(toy_robot.movement_history.size).to eql(7) }
    end

    context '#evaluate_command' do
      context 'MOVE command' do
        before { toy_robot.evaluate_command({ command: 'MOVE' }) }

        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_position_x).to eql(0) }
        it { expect(toy_robot.current_facing_direction).to eql('NORTH') }
        it { expect(toy_robot.movement_history.size).to eql(2) }
        it { expect(toy_robot.commands.size).to eql(7) }
        it { expect(toy_robot.output).to be_nil }
      end

      context 'LEFT command' do
        before { toy_robot.evaluate_command({ command: 'LEFT' }) }

        it { expect(toy_robot.current_position_y).to eql(0) }
        it { expect(toy_robot.current_position_x).to eql(0) }
        it { expect(toy_robot.current_facing_direction).to eql('WEST') }
        it { expect(toy_robot.movement_history.size).to eql(2) }
        it { expect(toy_robot.commands.size).to eql(7) }
        it { expect(toy_robot.output).to be_nil }
      end

      context 'RIGHT command' do
        before { toy_robot.evaluate_command({ command: 'RIGHT' }) }

        it { expect(toy_robot.current_position_y).to eql(0) }
        it { expect(toy_robot.current_position_x).to eql(0) }
        it { expect(toy_robot.current_facing_direction).to eql('EAST') }
        it { expect(toy_robot.movement_history.size).to eql(2) }
        it { expect(toy_robot.commands.size).to eql(7) }
        it { expect(toy_robot.output).to be_nil }
      end
    end

    context '#place' do
      before { toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'WEST' }) }

      it { expect(toy_robot.current_position_x).to eql(1) }
      it { expect(toy_robot.current_position_y).to eql(1) }
      it { expect(toy_robot.current_facing_direction).to eql('WEST') }
      it { expect(toy_robot.output).to be_nil }
      it { expect(toy_robot.movement_history.size).to eql(1) }
    end

    context '#move_forward' do
      context 'MOVE NORTH' do
        before { toy_robot.move_forward }

        it { expect(toy_robot.current_position_x).to eql(0) }
        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_facing_direction).to eql('NORTH') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end

      context 'MOVE WEST' do
        before do
          toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'WEST' })
          toy_robot.move_forward
        end

        it { expect(toy_robot.current_position_x).to eql(0) }
        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_facing_direction).to eql('WEST') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end

      context 'MOVE EAST' do
        before do
          toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'EAST' })
          toy_robot.move_forward
        end

        it { expect(toy_robot.current_position_x).to eql(2) }
        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_facing_direction).to eql('EAST') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end

      context 'MOVE SOUTH' do
        before do
          toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'SOUTH' })
          toy_robot.move_forward
        end

        it { expect(toy_robot.current_position_x).to eql(1) }
        it { expect(toy_robot.current_position_y).to eql(0) }
        it { expect(toy_robot.current_facing_direction).to eql('SOUTH') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end
    end

    context '#report' do
      before do
        toy_robot.move_forward
        toy_robot.report
      end

      it { expect(toy_robot.output).to eql('0,1,NORTH') }
      it { expect(toy_robot.movement_history.size).to eql(1) }
    end

    context '#turn_left' do
      context 'When facing NORTH' do
        before { toy_robot.turn_left }

        it { expect(toy_robot.current_position_x).to eql(0) }
        it { expect(toy_robot.current_position_y).to eql(0) }
        it { expect(toy_robot.current_facing_direction).to eql('WEST') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end

      context 'When facing WEST' do
        before do
          toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'WEST' })
          toy_robot.turn_left
        end

        it { expect(toy_robot.current_position_x).to eql(1) }
        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_facing_direction).to eql('SOUTH') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end

      context 'When facing SOUTH' do
        before do
          toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'SOUTH' })
          toy_robot.turn_left
        end

        it { expect(toy_robot.current_position_x).to eql(1) }
        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_facing_direction).to eql('EAST') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end

      context 'When facing EAST' do
        before do
          toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'EAST' })
          toy_robot.turn_left
        end

        it { expect(toy_robot.current_position_x).to eql(1) }
        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_facing_direction).to eql('NORTH') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end
    end

    context '#turn_right' do
      context 'When facing NORTH' do
        before { toy_robot.turn_right }

        it { expect(toy_robot.current_position_x).to eql(0) }
        it { expect(toy_robot.current_position_y).to eql(0) }
        it { expect(toy_robot.current_facing_direction).to eql('EAST') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end

      context 'When facing WEST' do
        before do
          toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'WEST' })
          toy_robot.turn_right
        end

        it { expect(toy_robot.current_position_x).to eql(1) }
        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_facing_direction).to eql('NORTH') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end

      context 'When facing SOUTH' do
        before do
          toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'SOUTH' })
          toy_robot.turn_right
        end

        it { expect(toy_robot.current_position_x).to eql(1) }
        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_facing_direction).to eql('WEST') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end

      context 'When facing EAST' do
        before do
          toy_robot.place({ command: 'PLACE', position_y: 1, position_x: 1, facing: 'EAST' })
          toy_robot.turn_right
        end

        it { expect(toy_robot.current_position_x).to eql(1) }
        it { expect(toy_robot.current_position_y).to eql(1) }
        it { expect(toy_robot.current_facing_direction).to eql('SOUTH') }
        it { expect(toy_robot.movement_history.size).to eql(1) }
      end
    end
  end
end