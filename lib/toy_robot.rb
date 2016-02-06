require './lib/table'

class ToyRobot
  VALID_ACTIONS = %w[MOVE LEFT RIGHT REPORT PLACE]

  def initialize(options={table: {x_size: 5, y_size: 5}})
    @table = Table.new(options[:table])
  end

  def run
    loop do
      get_action
    end
  end

  def get_action
    # <ACTION> [X,Y,DIRECTION]
    match_data = STDIN.gets.match(/^(\w*)\s((\d)\,(\d),(\w*))?$/)

    if match_data
      action = match_data[1]
      arg = match_data[2] # x,y,direction
      if VALID_ACTIONS.include?(action)
        case action
          when "PLACE"
            arg = arg.split(",")
            @table.place({x: arg[0].to_i, y: arg[1].to_i, direction: arg[2]})
          when "REPORT"
            puts @table.report.values.join(",") if @table.placed?
          else
            @table.move(action)
        end
      end
    end
  end
end
