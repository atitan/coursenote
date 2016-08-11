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

  describe ".fav_course_status" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user, favorite_courses: ['123', '456']) }

    context "user signed in" do
      it "returns nothing if fav_course empty" do
        allow(helper).to receive(:current_user).and_return(user)
        expect(helper.fav_course_status('123')).to eq('')
      end

      it "returns nothing if fav_course not found" do
        allow(helper).to receive(:current_user).and_return(another_user)
        expect(helper.fav_course_status('890')).to eq('')
      end

      it "returns style if fav_course matched" do
        allow(helper).to receive(:current_user).and_return(another_user)
        expect(helper.fav_course_status('123')).not_to eq('')
      end
    end

    context "user not signed in" do
      it "returns nothing" do
        allow(helper).to receive(:current_user).and_return(nil)
        expect(helper.fav_course_status('123')).to eq('')
      end
    end
  end

  describe ".vote_status" do
    let(:comment) { create(:comment) }
    let(:another_comment) { create(:comment) }
    let(:user) { create(:user) }

    before do
      user.votes.create(votable: comment, upvote: false)
    end

    context "if votes exists" do
      it "returns nothing if not found" do
        assign(:votes, user.votes)
        expect(helper.vote_status(another_comment, true)).to eq('')
      end

      it "returns nothing if non matched" do
        assign(:votes, user.votes)
        expect(helper.vote_status(comment, true)).to eq('')
      end

      it "returns style if matched" do
        assign(:votes, user.votes)
        expect(helper.vote_status(comment, false)).not_to eq('')
      end
    end

    context "if votes is empty" do
      it "returns nothing" do
        assign(:votes, [])
        expect(helper.vote_status(comment, true)).to eq('')
      end
    end

    context "if votes not exist" do
      it "returns nothing" do
        assign(:votes, nil)
        expect(helper.vote_status(comment, true)).to eq('')
      end
    end
  end

  describe ".render_flash" do
    it "render alert as danger" do
      value = double('message')

      expect(helper).to receive(:render).with(partial: 'common/flash', locals: { type: 'danger', message: value })
      helper.render_flash('alert', value)
    end

    it "render error as danger" do
      value = double('message')

      expect(helper).to receive(:render).with(partial: 'common/flash', locals: { type: 'danger', message: value })
      helper.render_flash('error', value)
    end

    it "render warning as warning" do
      value = double('message')

      expect(helper).to receive(:render).with(partial: 'common/flash', locals: { type: 'warning', message: value })
      helper.render_flash('warning', value)
    end

    it "render notice as info" do
      value = double('message')

      expect(helper).to receive(:render).with(partial: 'common/flash', locals: { type: 'info', message: value })
      helper.render_flash('notice', value)
    end

    it "render success as success" do
      value = double('message')

      expect(helper).to receive(:render).with(partial: 'common/flash', locals: { type: 'success', message: value })
      helper.render_flash('success', value)
    end
  end
end
