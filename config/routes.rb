Rails.application.routes.draw do

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
