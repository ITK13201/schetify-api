Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace 'api' do
    namespace 'v1' do
      post 'user', to: 'user#create_user'
      get 'events', to: 'events#index'
      get 'events/:id', to: 'events#show'
    end
  end
end
