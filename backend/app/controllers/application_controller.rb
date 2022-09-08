class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate
  before_action :find_user
  # before_action :find_dummy_user

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      uid = FirebaseAuth.authenticate(token)
      params[:uid] = uid
    rescue StandardError
      render json: { message: 'Authentication Failed!' }, status: :unauthorized
    end
  end

  def find_user
    user = User.find_by(firebase_id: params[:uid])
    render json: { message: 'Invalid user!' }, status: :forbidden unless user
    @user = user
  end

  # def find_dummy_user
  #   @user = User.all.limit(1)[0]
  # end
end
