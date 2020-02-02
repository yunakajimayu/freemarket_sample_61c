Rails.application.routes.draw do
  root 'items#index'
  # ↓後で変更して消します
  root 'users#index'
end