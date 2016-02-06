require './lib/robot'

class Table
  ORIENTATION = {
    north: { y: 1  },
    east:  { x: 1  },
    south: { y: -1 },
    west:  { x: -1 }
  } 

  def initialize(options={x_size: 5, y_size: 5})
    @x_size = options[:x_size]
    @y_size = options[:y_size]
  end

  def place(options)
    x, y = options.to_a
    if [x, y].all? {|coordinate, pos| valid_move?(coordinate, pos) }
      @robot = Robot.new(options)
    end
  end

  def placed?
    @robot != nil
  end

  def report
    @robot.report if placed?
  end

  def direction=(direction)
    @robot.direction = direction
  end

  def move(action)
    if placed?
      current_direction = self.report[:direction].downcase.to_sym
      case action
        when "MOVE"
          coordinate, pos = ORIENTATION[current_direction].to_a.flatten
          move_to = @robot.report[coordinate] + pos
          @robot.move_to({coordinate => move_to}) if valid_move?(coordinate, move_to)
        when "LEFT"
          index = ORIENTATION.keys.index(current_direction) - 1
          direction = ORIENTATION.keys[index].to_s.upcase
          self.place(@robot.report.merge({direction: direction}))
        when "RIGHT"
          index = ORIENTATION.keys.index(current_direction) + 1
          index = 0 if index == 4 # Handle west -> north
          direction = ORIENTATION.keys[index].to_s.upcase
          self.place(@robot.report.merge({direction: direction }))
      end
    end
  end

private
  def valid_move?(coordinate, move_to)
    max_pos = self.instance_variable_get("@#{coordinate}_size")
    # Within table size
    return !(move_to > max_pos || move_to < 0)
  end
end
