# frozen_string_literal: true

class UserController < ApplicationController
  skip_before_action :find_user, only: :create_user
  def create_user
    user = User.new(firebase_id: params[:uid], username: params[:username])
    if user.save
      render json: { user_id: user.id }, status: :ok
    else
      render json: { message: 'user creation failed!' }, status: :internal_server_error
    end
  rescue StandardError
    render json: { message: 'user creation failed!' }, status: :internal_server_error
  end
end
