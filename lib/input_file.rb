require_relative 'toy_robot'

class InputFile
  attr_accessor :commands

  def initialize(location)
    @commands = []
    get_lines_from_file(location)
  end

  private

  def get_lines_from_file(location)
    File.readlines(location).map do |line|
      @commands << ToyRobot.validate_command(line)
    end

    @commands.compact!
  end
end