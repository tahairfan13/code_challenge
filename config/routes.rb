Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'copy' => 'copy#index'
  get 'copy/refresh' => 'copy#reset'
  get 'copy/:key' => 'copy#show'
end
