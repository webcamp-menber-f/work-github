Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {　registrations: 'customers/registrations',
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: 'admin/sessions'
  }

  scope module: :public do
   root :to => 'homes#top'
   get 'about' => 'homes#about'
   get 'customers/withdraw' => 'customers#withdraw'
   patch 'customers/unsubscribe' => 'customers#unsubscribe'
   delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
   post 'orders/confirm' => 'orders#confirm'
   get 'orders/complete' => 'orders#complete'
   get 'customers/mypage' => 'customers#show'
   get 'customers/edit' => 'customers#edit'
   patch 'customers/update' => 'customers#update'
   resources :items, only: [:index, :show]

   resources :carts, only: [:index, :update, :destroy, :create] do
     collection do
       delete "destroy_all"
      end
  end

   resources :orders, only: [:new, :create, :index, :show]
   resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  end

  namespace :admin do
    root :to => 'items#index'
    get 'orders/history/:id' => 'orders#history', as: 'orders_history'
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :goods_genres, only:[:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
