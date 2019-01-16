Rails.application.routes.draw do
 
  namespace 'api' do
    namespace 'v1' do
      resources :areas, only: [:index]
      resources :users, only: [:create]
      resources :scores, only: [:index, :create]
      resources :images, only: [:show]
    end
  end

end
