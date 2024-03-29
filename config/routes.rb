# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :users
  resources :organizations do
    resources :projects do
      resources :reports do
        resources :notes
      end
    end
  end

  mount Annotable::Engine, at: 'v1'
end
