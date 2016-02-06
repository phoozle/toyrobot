require 'table'

RSpec.describe Table do
  let(:table) { Table.new x_size: 5, y_size: 5 }
  let(:robot_options) { {x: 0, y: 0, direction: "NORTH"} }

  before {
    table.place(robot_options)
  }

  describe "#place" do
    let(:robot_options) { {x: 4, y: 4, direction: "NORTH"} }

    it "places a robot at given coordinate" do
      expect(table.report).to eq(robot_options)
    end

    context "invalid position" do
      let(:robot_options) { {x: 10, y: -1, direction: "NORTH"} }

      it "does't place a robot" do
        expect(table.placed?).to be(false)
      end
    end
  end

  it "reports it's position and direction" do
    expect(table.report).to eq(robot_options)
  end

  describe "#move" do
    context "NORTH" do
      let(:robot_options) { {x: 3, y: 3, direction: "NORTH"} }

      it "rotates left" do
        table.move("LEFT")
        expect(table.report[:direction]).to eq("WEST")
      end

      it "rotates right" do
        table.move("RIGHT")
        expect(table.report[:direction]).to eq("EAST")
      end

      it "moves" do
        table.move("MOVE")
        expect(table.report[:y]).to eq(4)
      end
    end

    context "SOUTH" do
      let(:robot_options) { {x: 3, y: 3, direction: "SOUTH"} }

      it "rotates left" do
        table.move("LEFT")
        expect(table.report[:direction]).to eq("EAST")
      end

      it "rotates right" do
        table.move("RIGHT")
        expect(table.report[:direction]).to eq("WEST")
      end

      it "moves" do
        table.move("MOVE")
        expect(table.report[:y]).to eq(2)
      end
    end

    context "EAST" do
      let(:robot_options) { {x: 3, y: 3, direction: "EAST"} }

      it "rotates left" do
        table.move("LEFT")
        expect(table.report[:direction]).to eq("NORTH")
      end

      it "rotates right" do
        table.move("RIGHT")
        expect(table.report[:direction]).to eq("SOUTH")
      end

      it "moves" do
        table.move("MOVE")
        expect(table.report[:x]).to eq(4)
      end
    end

    context "WEST" do
      let(:robot_options) { {x: 3, y: 3, direction: "WEST"} }

      it "rotates left" do
        table.move("LEFT")
        expect(table.report[:direction]).to eq("SOUTH")
      end

      it "rotates right" do
        table.move("RIGHT")
        expect(table.report[:direction]).to eq("NORTH")
      end

      it "moves" do
        table.move("MOVE")
        expect(table.report[:x]).to eq(2)
      end
    end

    context "invalid direction" do
      let(:robot_options) { {x: 0, y: 0, direction: "NORTH"} }

      it "doesn't fall off the table" do
        6.times do
          table.move("MOVE")
        end
        expect(table.report[:y]).to eq(5)
      end
    end
  end

  describe "#direction=" do
    it "sets robots direction" do
      table.direction = "EAST"
      expect(table.report[:direction]).to eq("EAST")
    end
  end
end
