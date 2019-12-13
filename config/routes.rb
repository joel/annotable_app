# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :reports
  resources :users
  resources :organizations do
    resources :projects
  end
end
