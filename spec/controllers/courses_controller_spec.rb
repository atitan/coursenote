require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:course) { create(:course) }

  describe "index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "show" do
    it "renders the show template" do
      get :show, id: course.id
      expect(response).to render_template("show")
    end
  end

  describe "vote" do
    it 'requires you to be logged in' do
      xhr :post, :vote, course_id: course.id
      expect(response).to have_http_status(401)
    end

    describe 'logged in' do
      login_user


    end
  end
end
