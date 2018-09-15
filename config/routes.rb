Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :books do
        put :approve, on: :member
        put :reject, on: :member
      end
      resources :categories
    end
  end

end
