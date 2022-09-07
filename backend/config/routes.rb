Rails.application.routes.draw do
  post 'user', to: 'user#create_user'
end
