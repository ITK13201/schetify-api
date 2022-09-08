Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace 'api' do
    namespace 'v1' do
      post 'user', to: 'user#create_user'
      get 'events', to: 'events#index'
      get 'events/:id', to: 'events#show'
      post 'events', to: 'events#create'
      put 'events/:id', to: 'events#update'
      namespace 'events' do
        put ':event_id/schedule_candidates', to: 'schedule_candidates#update'
      end
    end
  end
end
