class UsersController < ApplicationController
  layout false

  def show
    render layout: 'users'
  end

  def profile
    render layout: 'users'
  end
  
    

  def identification
    render layout: 'users'
  end

end
