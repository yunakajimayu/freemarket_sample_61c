Rails.application.routes.draw do
  root 'items#index'
  resource :items ,path:'//' do
    get 'sell',on: :collection
  end
  resource :user,path: '/mypage/' do
    get 'profile',on: :collection
  end
end