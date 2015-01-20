Rails.application.routes.draw do
  resources :papers do
    collection do
      get "search"
    end
  end
end
