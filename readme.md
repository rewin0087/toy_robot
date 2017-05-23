# Toy Robot Simulator

## Description
- The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement
that would result in the robot falling from the table must be prevented, however further valid movement commands must still
be allowed.

Create an application that can read in commands of the following form

    PLACE X,Y,F
    MOVE
    LEFT
    RIGHT
    REPORT

- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
- MOVE will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.
- A robot that is not on the table can choose the ignore the MOVE, LEFT, RIGHT and REPORT commands.
- Input can be from a file, or from standard input, as the developer chooses.
- Provide test data to exercise the application.

## Constraints

The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.

## Example Input and Output

a)

    PLACE 0,0,NORTH
    MOVE
    REPORT
    Output: 0,1,NORTH

b)

    PLACE 0,0,NORTH
    LEFT
    REPORT
    Output: 0,0,WEST

c)

    PLACE 1,2,EAST
    MOVE
    MOVE
    LEFT
    MOVE
    REPORT
    Output: 3,3,NORTH

## How to run

Open the root directory in the terminal then run deploy_toy_robot bash file with a location_path for the input file as '*.txt' format or you can skip the location_path and it will use the default input.txt file as default source of input.

With input file location path (will use /path/to/input_file.txt as the source of input):

    ./deploy_toy_robot /path/to/input_file.txt # This will print like this '3,3,NORTH'

Without input file location path and will use the default input.txt file for input source:

    ./deploy_toy_robot # This will print like this '3,3,NORTH'


You can run the code also in the irb. Run irb in the root directory in the terminal.

With input file location path:

    irb
    require_relative 'table'
    input_location_path = '/path/to/input_file.txt'
    TableTop.new(input_location_path).place_toy_robot_and_execute # This will print like this '3,3,NORTH'

Without input file location path:

    irb
    require_relative 'table'
    TableTop.new.place_toy_robot_and_execute # This will print like this '3,3,NORTH'

## How to run specs

To run the rspec tests, run rspec in the root of the directory in the terminal.

    rspec
