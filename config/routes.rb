Rails.application.routes.draw do
  root to: 'items#index'
  resource :user,path: '/mypage/' do
    get 'profile',on: :collection
    get 'identification',on: :collection
    get 'logout', on: :collection
  end
  


  resources :items ,path:'/jp',except: :new do
    collection do
      get 'sell'
      get 'transaction'
      post 'purchase'
      get 'done'
    end

  end
  
  resource :user,path: 'jp/mypage/' do
    get 'profile',on: :collection
  end
  devise_for :users, path: '', controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :creditcards, path:'jp/mypage/card/', only: [:index, :create, :new, :destroy]
  
  devise_scope :user do 
    get '/jp/signup', to: "users/registrations#new_page"
    get '/jp/signup/registration/', to: 'users/registrations#new'
    post'/jp/signup/registration/', to: 'users/registrations#create'
    get '/jp/signup/sms_confirmation/', to: 'users/registrations#new_profile'
    post '/jp/signup/sms_confirmation/', to: 'users/registrations#create_profile'
    get '/jp/signup/sms_confirmation/sms/', to: 'users/registrations#new_authorization'
    post '/jp/signup/sms_confirmation/sms/', to: 'users/registrations#create_authorization'
    get '/jp/signup/address/', to: 'users/registrations#new_address'
    post '/jp/signup/address/', to: 'users/registrations#create_address'
    get '/jp/signup/credit_card/', to: 'users/registrations#new_credit'
    post '/jp/signup/credit_card/', to: 'users/registrations#create_credit'
    get '/jp/signup/done/', to: 'users/registrations#done'
  end
end