# frozen_string_literal: true

module Api
  module V1
    class UserController < ApplicationController
      skip_before_action :find_user, only: :create_user
      def create_user
        user = User.new(firebase_id: params[:uid], username: params[:username])
        raise unless user.save

        render json: { user_id: user.id }, status: :ok
      rescue StandardError
        render json: { message: 'user creation failed!' }, status: :internal_server_error
      end
    end
  end
end
