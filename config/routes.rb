Rails.application.routes.draw do
  root 'items#index'
  resource :user,path: '/mypage/' do
    get 'profile',on: :collection
    get 'identification',on: :collection
  end
end