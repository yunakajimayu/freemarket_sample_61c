class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  require "payjp"

  def new_page
  end

  def new
    @user = User.new
  end

  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
      @user = User.new(user_params)
      unless @user.valid?
        flash.now[:alert] = @user.errors.full_messages
        render :new and return
      end
      session["devise.regist_data"] = {user: @user.attributes}
      session["devise.regist_data"][:user]["password"] = params[:user][:password]
      @profile = @user.build_profile
      render :new_profile

    else
      @user = User.new(user_params)
      unless @user.valid?
        flash.now[:alert] = @user.errors.full_messages
        render :new and return
      end
      session["devise.regist_data"] = {user: @user.attributes}
      session["devise.regist_data"][:user]["password"] = params[:user][:password]

      @profile = @user.build_profile
      render :new_profile
    end
  end

  def create_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(profile_params)
    unless @profile.valid?
      flash.now[:alert] = @profile.errors.full_messages
      render :new_profile and return
    end
    session["devise.regist_data2"] = {profile: @profile.attributes}
    @authorization = @user.build_authorization
    render :new_authorization
  end

  def create_authorization
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["devise.regist_data2"]["profile"])
    @authorization = Authorization.new(authorization_params)
    unless @authorization.valid?
      flash.now[:alert] = @authorization.errors.full_messages
      render :new_authorization and return
    end
    session["devise.regist_data3"] = {authorization: @authorization.attributes}
    @address = @user.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["devise.regist_data2"]["profile"])
    @authorization = Authorization.new(session["devise.regist_data3"]["authorization"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    session["devise.regist_data4"] = {address: @address.attributes}
    render :new_credit
  end

  def create_credit
    Payjp.api_key = "sk_test_06207c0e157a821b64f2bcdc"
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["devise.regist_data2"]["profile"])
    @authorization = Authorization.new(session["devise.regist_data3"]["authorization"])
    @address = Address.new(session["devise.regist_data4"]["address"])

    User.transaction do
      @user.save!
      @profile.save!
      @authorization.save!
      @address.save!
    end
    session[:id] = @user.id
    sign_in User.find(session[:id]) unless user_signed_in?

    if params['payjp-token'].blank?
      redirect_to action: 'new'
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
      @credit = Credit.new(user_id: session[:id], customer_id: customer.id, card_id: customer.default_card)
      @credit.save!
      render :done
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date)
  end

  def profile_params
    params.require(:profile).permit(:tell_number, :profile, :profile_image)
  end

  def authorization_params
    params.require(:authorization).permit(:authorization_number)
  end

  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :zipcode, :prefecture, :city, :address, :address_building)
  end

end
