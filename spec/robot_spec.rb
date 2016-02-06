require 'robot'

RSpec.describe Robot do
  let(:robot) { Robot.new x: 0, y: 0, direction: "NORTH" }

  describe "initialization" do
    it "initializes" do
      expect(robot).to be_a(Robot)
    end

    it "set position and direction" do
      expect(robot.report).to eq({x: 0, y: 0, direction: "NORTH"})
    end
  end

  describe "#move_to" do
    it "moves to x position" do
      robot.move_to(x: 2)
      expect(robot.report[:x]).to eq(2)
    end

    it "moves to y position" do
      robot.move_to(y: 6)
      expect(robot.report[:y]).to eq(6)
    end
  end

  describe "#direction=" do
    it "sets direction" do
      robot.direction = "SOUTH"
      expect(robot.report[:direction]).to eq("SOUTH")
    end
  end
end
