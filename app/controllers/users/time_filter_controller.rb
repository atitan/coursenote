class Users::TimeFilterController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    if current_user.update(time_filter: params[:time_filter])
      render json: current_user
    else
      render json: { error: current_user.errors.full_messages }, status: :internal_server_error
    end
  end
end
