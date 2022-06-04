Rails.application.routes.draw do
  resources :applications, param: :access_token do
    resources :chats, param: :number do
      resources :messages, param: :message_id
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
