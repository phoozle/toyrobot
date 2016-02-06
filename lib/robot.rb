class Robot
  attr_writer :direction

  def initialize(options={})
    @x = options[:x]
    @y = options[:y]
    @direction = options[:direction]
  end

  def report
    {
      x: @x,
      y: @y,
      direction: @direction
    }
  end

  def move_to(coordinate)
    name = "@#{coordinate.to_a.flatten[0]}".to_sym
    value = coordinate.to_a.flatten[1]

    self.instance_variable_set(name, value)
  end
end
