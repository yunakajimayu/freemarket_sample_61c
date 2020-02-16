class Users::SessionsController < Devise::SessionsController
  layout false

  def new
    render layout: 'devise' 
  end
  
end
