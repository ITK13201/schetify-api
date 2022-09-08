Rails.application.routes.draw do
  scope '/api/v1' do
    post 'user', to: 'user#create_user'
  end
end
