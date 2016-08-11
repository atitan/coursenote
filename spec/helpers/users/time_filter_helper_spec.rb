require 'rails_helper'

RSpec.describe Users::TimeFilterHelper, type: :helper do
  describe ".timetable_to_string" do
    it "returns message indicate if empty" do
      timetable = {}
      expect(helper.timetable_to_string(timetable)).to eq("空的")
    end

    it "returns timetable without html <br>" do
      timetable = {'1' => ['1','2','3','4','A','B','C']}
      expect(helper.timetable_to_string(timetable)).to eq("1-1234ABC")
    end

    it "returns timetable with html <br>" do
      timetable = {'1' => ['1','2','3'], '2' => ['A','B','C']}
      expect(helper.timetable_to_string(timetable)).to eq("1-123<br>2-ABC")
    end
  end
end
