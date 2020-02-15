Rails.application.routes.draw do

  root to: 'items#index'
  resource :user,path: '/mypage/' do
    get 'profile',on: :collection
    get 'identification',on: :collection
    get 'logout', on: :collection
  end
  get "jp/signup/" => "items#new"
  root 'items#index'
  
  resource :items ,path:'/jp/' do
    get 'sell',on: :collection
    get "signup" => "items#new"
  end
  
  resource :user,path: 'jp/mypage/' do
    get 'profile',on: :collection
  end
  devise_for :users, path: '', controllers: {
    registrations: 'users/registrations',
  }
  
    
  devise_scope :user do
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
