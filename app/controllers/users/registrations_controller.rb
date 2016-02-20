class Users::RegistrationsController < Devise::RegistrationsController
  # DELETE /resource
  def destroy
    #super
    redirect_to root_path
  end
end
