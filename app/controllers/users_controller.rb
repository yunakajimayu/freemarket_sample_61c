class UsersController < ApplicationController
  layout false
  def show
    
  end

  def profile
    render layout: 'users'
  end
  
end
