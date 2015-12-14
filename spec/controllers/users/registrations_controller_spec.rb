require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe "destroy" do
    login_user

    it "should redirect_to root_path" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
