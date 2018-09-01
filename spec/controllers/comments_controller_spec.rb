require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:comment) { create(:comment) }

  describe "create" do
    it 'requires you to be logged in' do
      post :create, xhr: true
      expect(response).to have_http_status(401)
    end
    
  end

  describe "update" do
    it 'requires you to be logged in' do
      post :update, params: { id: comment.id }, xhr: true
      expect(response).to have_http_status(401)
    end
    
  end

  describe "destroy" do
    it 'requires you to be logged in' do
      post :destroy, params: { id: comment.id }, xhr: true
      expect(response).to have_http_status(401)
    end
    
  end

  describe "vote" do
    it 'requires you to be logged in' do
      post :vote, params: { id: comment.id }, xhr: true
      expect(response).to have_http_status(401)
    end
    
  end
end
