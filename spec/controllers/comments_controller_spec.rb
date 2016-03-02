require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:comment) { create(:comment) }

  describe "create" do
    it 'requires you to be logged in' do
      xhr :post, :create
      expect(response).to have_http_status(401)
    end
    
  end

  describe "update" do
    it 'requires you to be logged in' do
      xhr :post, :update, id: comment.id
      expect(response).to have_http_status(401)
    end
    
  end

  describe "destroy" do
    it 'requires you to be logged in' do
      xhr :post, :destroy, id: comment.id
      expect(response).to have_http_status(401)
    end
    
  end

  describe "vote" do
    it 'requires you to be logged in' do
      xhr :post, :vote, comment_id: comment.id
      expect(response).to have_http_status(401)
    end
    
  end
end
