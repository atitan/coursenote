require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe ".concat_title" do
    it "concats two string together" do
      expect(helper.concat_title('Apple', 'Orange')).to eq('Orange - Apple')
      expect(helper.concat_title('Peach', 'Watermelon', true)).to eq('Peach - Watermelon')
    end
  end

  describe ".time_overlap?" do
    let(:user) { create(:user, time_filter: {'1' => ['1','2','3','4']}) }

    context "user signed in" do
      it "returns nothing if not overlap" do
        expect(helper.time_overlap?({'1' => ['1','2','3','4']}, user)).to eq('')
      end

      it "returns style if overlap" do
        expect(helper.time_overlap?({'1' => ['1','2','3','4'], '2' => ['1']}, user)).not_to eq('')
      end
    end

    context "user not signed in" do
      it "returns nothing" do
        expect(helper.time_overlap?({'1' => ['1','2','3','4']}, nil)).to eq('')
      end
    end
  end
end
