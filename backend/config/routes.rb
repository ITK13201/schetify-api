Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace 'api' do
    namespace 'v1' do
      get 'events/:id' => 'events#index'
      post 'user', to: 'user#create_user'
    end
  end
end
