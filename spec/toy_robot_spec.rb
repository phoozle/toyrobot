require './lib/toy_robot'

RSpec.describe ToyRobot do
  let(:toy_robot) { ToyRobot.new }

  before {
    allow(STDIN).to receive(:gets) { "PLACE 0,0,NORTH\n" }
    toy_robot.get_action
  }

  it "places robot" do
    send_action "REPORT"
    expect {toy_robot.get_action}.to output("0,0,NORTH\n").to_stdout
  end

  it "moves robot" do
    send_action "MOVE"
    toy_robot.get_action

    send_action "REPORT"
    expect {toy_robot.get_action}.to output("0,1,NORTH\n").to_stdout
  end

  it "turns robot left" do
    send_action "LEFT"
    toy_robot.get_action

    send_action "REPORT"
    expect {toy_robot.get_action}.to output("0,0,WEST\n").to_stdout
  end

  it "turns robot right" do
    send_action "RIGHT"
    toy_robot.get_action

    send_action "REPORT"
    expect {toy_robot.get_action}.to output("0,0,EAST\n").to_stdout
  end

  def send_action(action)
    allow(STDIN).to receive(:gets) { action + "\n" }
  end
end
