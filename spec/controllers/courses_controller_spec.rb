require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let!(:course) { create(:course) }

  describe "index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns http 404 if nothing found" do
      get :index, params: { page: 999999 }
      expect(response).to have_http_status(404)
    end
  end

  describe "show" do
    it "renders the show template" do
      get :show, params: { id: course.id }
      expect(response).to render_template("show")
    end

    it "returns http 404 if id not found" do
      expect {
        get :show, params: { id: 999999 }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "vote" do
    it 'requires you to be logged in' do
      post :vote, params: { id: course.id }, xhr: true
      expect(response).to have_http_status(401)
    end

    describe 'logged in' do
      login_user

      it 'returns http 200 if voted successfully' do
        post :vote, params: { id: course.id }, xhr: true
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "title" do
    
  end

  describe "instructor" do
    
  end
end
