require_relative 'input_file'

class Table
  attr_accessor :dimensions,
    :commands,
    :toy_robot,
    :input_file_location,
    :toy_robot_current_position

  def initialize(input_file_location = nil, dimension_x = nil, dimension_y = nil)
    @input_file_location = input_file_location || 'input.txt'
    @commands = []
    set_dimension(dimension_x, dimension_y)
  end

  def place_toy_robot_and_execute
    @commands = InputFile.new(@input_file_location).commands
    place_command = @commands.shift
    total_commands = @commands.size

    if place_command[:command] != ToyRobot.place
      place_command = nil
      next_place_command_index = @commands.index{|c| c[:command] == ToyRobot.place }
      unless next_place_command_index.nil?
        @commands = @commands[next_place_command_index..total_commands]
        place_command = @commands.shift
      end
    end

    return if place_command.nil?

    @toy_robot = ToyRobot.new(place_command[:position_x], place_command[:position_y], place_command[:facing], @dimensions, @commands)
    @toy_robot.execute_commands
    @toy_robot_current_position = @toy_robot.output
  end

  private

  def set_dimension(dimension_x, dimension_y)
    @dimensions =  if dimension_x && dimension_y
      { x: dimension_x, y: dimension_y }
    else
      { x: 5, y: 5 }
    end
  end
end