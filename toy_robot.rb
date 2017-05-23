class ToyRobot
  attr_accessor :current_position_x,
    :current_position_y,
    :current_facing_direction,
    :table_dimensions,
    :commands,
    :movement_history,
    :output

  COMPASS = %w(NORTH SOUTH WEST EAST)
  ACTIONS = %w(LEFT RIGHT MOVE REPORT PLACE)

  COMPASS.each do |direction|
    define_singleton_method direction.downcase do
      direction
    end
  end

  ACTIONS.each do |action|
    define_singleton_method action.downcase do
      action
    end
  end

  def self.validate_command(line)
    sequence = line.strip
    if sequence.include?(ToyRobot.place)
      place = self.place
      initial_position = sequence.sub(place, '').strip.split(',')
      return if initial_position.size != 3

      position_x = initial_position[0].to_i
      position_y = initial_position[1].to_i
      facing = initial_position[2]

      return unless COMPASS.include?(facing)

      { command: place, position_x: position_x, position_y: position_y, facing: facing }
    elsif ACTIONS.include?(sequence)
      { command: sequence }
    end
  end

  def initialize(initial_position_x, initial_position_y, initial_facing_direction, table_dimensions, commands)
    @current_position_x = initial_position_x
    @current_position_y = initial_position_y
    @current_facing_direction = initial_facing_direction
    @table_dimensions = table_dimensions
    @commands = commands
    @movement_history = []
    save_current_state!
  end

  def execute_commands
    @commands.each do |command|
      evaluate_command(command)
    end
  end

  def evaluate_command(command)
    case command[:command]
    when ToyRobot.right
      turn_right
    when ToyRobot.left
      turn_left
    when ToyRobot.move
      move_forward
    when ToyRobot.report
      report
    when ToyRobot.place
      place(command)
    end

    save_current_state!
    validate_latest_position!
  end

  def place(command)
    @current_position_x = command[:position_x]
    @current_position_y = command[:position_y]
    @current_facing_direction = command[:facing]
  end

  def move_forward
    case @current_facing_direction
    when ToyRobot.north
      @current_position_y += 1
    when ToyRobot.west
      @current_position_x -= 1
    when ToyRobot.east
      @current_position_x += 1
    when ToyRobot.south
      @current_position_y -= 1
    end
  end

  def report
    @output = "#{@current_position_x},#{@current_position_y},#{@current_facing_direction}"
    @output
  end

  private

  def validate_latest_position!
    unless valid_current_position?
      @movement_history.pop
      last_position = @movement_history.last
      # set last position
      @current_position_x = last_position[:current_position_x]
      @current_position_y = last_position[:current_position_y]
      @current_facing_direction = last_position[:current_facing_direction]
    end
  end

  def valid_current_position?
    @current_position_y <= @table_dimensions[:y] && @current_position_x <= @table_dimensions[:x] && @current_position_y >= 0 && @current_position_x >= 0
  end

  def save_current_state!
    @movement_history << { current_position_y: @current_position_y, current_position_x: @current_position_x, current_facing_direction: @current_facing_direction }
  end

  def turn_left
    case @current_facing_direction
    when ToyRobot.north
      @current_facing_direction = ToyRobot.west
    when ToyRobot.west
      @current_facing_direction = ToyRobot.south
    when ToyRobot.east
      @current_facing_direction = ToyRobot.north
    when ToyRobot.south
      @current_facing_direction = ToyRobot.east
    end
  end

  def turn_right
    case @current_facing_direction
    when ToyRobot.north
      @current_facing_direction = ToyRobot.east
    when ToyRobot.west
      @current_facing_direction = ToyRobot.north
    when ToyRobot.east
      @current_facing_direction = ToyRobot.south
    when ToyRobot.south
      @current_facing_direction = ToyRobot.west
    end
  end
end