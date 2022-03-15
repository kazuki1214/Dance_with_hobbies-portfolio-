Rails.application.routes.draw do


  scope module: :end_users do
    root "homes#top"
    get "end_users/:id/user_page" => "end_users#show", as: "user_page"
    get "end_user/:id/information" => "end_users#edit", as: "information"
    resources :end_user, only:[:update] do
      member do
        patch :withdraw
      end
      resources :post_histories, only:[:index, :show, :destroy]
      resources :followers, only:[:index, :create, :destroy]
      resources :notifications, only:[:index]
    end

    resources :categories, only:[:index]
    resources :hobbies, only:[:index, :show] do
      resources :favorite_hobbies, only:[:create, :destroy]
      resources :posts, except:[:edit, :update] do
          collection do
            post :confirm
          end
        resources :post_comments, only:[:index, :create, :destroy]
        resource :favorite_posts, only:[:create, :destroy]
      end
   end


  end

  devise_for :end_users, controllers:{
    registrations: 'end_users/registrations',
    sessions: 'end_users/sessions',
    passwords: 'end_users/passwords'
  }


  devise_for :admins, controllers:{
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :admin do
    root "homes#top"
    resources :hobbies, except:[:index]
    resources :end_users, except:[:new, :create, :destroy] do
      resources :post_histories, only:[:index, :show, :destroy]
    end
    resources :categories, only:[:index, :create, :destroy]
    resources :inquiries, except:[:new, :edit, :create]
  end

end
