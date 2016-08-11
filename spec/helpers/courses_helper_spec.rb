require 'rails_helper'

RSpec.describe CoursesHelper, type: :helper do
  helper do
    def user_signed_in?
      !current_user.nil?
    end
  end

  describe ".page_to_title" do
    it "returns page number in Chinese" do
      expect(helper.page_to_title(1)).to eq('第1頁')
      expect(helper.page_to_title(10)).to eq('第10頁')
      expect(helper.page_to_title(100)).to eq('第100頁')
    end
  end

  describe ".course_status" do
    it "converts boolean to Chinese" do
      expect(helper.course_status(true)).to eq('是')
      expect(helper.course_status(false)).to eq('否')
    end
  end

  describe ".avatar_path" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:comment) { create(:comment, user: user) }

    context "user signed in" do
      it "returns indicator if user is author" do
        allow(helper).to receive(:current_user).and_return(user)
        expect(helper.avatar_path(comment)).to eq("user-indicator.png")
      end

      it "returns avatar path if not author" do
        allow(helper).to receive(:current_user).and_return(another_user)
        expect(helper.avatar_path(comment)).to eq("https://secure.gravatar.com/avatar/#{comment.avatar}?d=identicon&s=40")
      end
    end

    context "user not signed in" do
      it "returns avatar path" do
        allow(helper).to receive(:current_user).and_return(nil)
        expect(helper.avatar_path(comment)).to eq("https://secure.gravatar.com/avatar/#{comment.avatar}?d=identicon&s=40")
      end
    end
  end

  describe ".category_button" do
    it "indicate active if matched params in URL" do
      allow(helper).to receive(:params).and_return({:by_category => ['宗哲']})
      expect(helper.category_button('宗哲')).to eq([true, '宗哲'])
    end

    it "indicate not active if no matched params in URL" do
      allow(helper).to receive(:params).and_return({:by_category => []})
      expect(helper.category_button('宗哲')).to eq([nil, '宗哲'])
    end

    it "add trailing 學 if name.length == 1" do
      allow(helper).to receive(:params).and_return({:by_category => []})
      expect(helper.category_button('人')).to eq([nil, '人學'])
    end
  end
end
