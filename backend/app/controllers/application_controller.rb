class ApplicationController < ActionController::API
  before_action :find_dummy_user
  def find_dummy_user
    @user = User.all.limit(1)[0]
  end
end
