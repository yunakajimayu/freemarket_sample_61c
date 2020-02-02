Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  get "items/signup/" => "items#new"
  devise_for :users, path: '', controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get '/home/signup/registration/', to: 'users/registrations#new'
    post'/home/signup/registration/', to: 'users/registrations#create'
    get '/home/signup/sms_confirmation/', to: 'users/registrations#new_profile'
    post '/home/signup/sms_confirmation/', to: 'users/registrations#create_profile'
    get '/home/signup/sms_confirmation/sms/', to: 'users/registrations#new_authorization'
    post '/home/signup/sms_confirmation/sms/', to: 'users/registrations#create_authorization'
    get '/home/signup/address/', to: 'users/registrations#new_address'
    post '/home/signup/address/', to: 'users/registrations#create_address'
    get '/home/signup/credit_card/', to: 'users/registrations#new_credit'
    post '/home/signup/credit_card/', to: 'users/registrations#create_credit'
    get '/home/signup/done/', to: 'users/registrations#done'
  end
end