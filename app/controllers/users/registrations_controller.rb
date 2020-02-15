<<<<<<< HEAD
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    @user = User.new
  end

  def create
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
    @credit = @user.build_credit
    render :new_credit
  end

  def create_credit
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["devise.regist_data2"]["profile"])
    @authorization = Authorization.new(session["devise.regist_data3"]["authorization"])
    @address = Address.new(session["devise.regist_data4"]["address"])
    @credit = Credit.new(credit_params)
    unless @credit.valid?
      flash.now[:alert] = @credit.errors.full_messages
      render :new_credit and return
    end
    @credit = @user.build_credit(@credit.attributes)

    User.transaction do
      @user.save!
      @profile.save!
      @authorization.save!
      @address.save!
      @credit.save!
    end

    @id = Credit.find(@credit.id)
    @user.update(id: @id.user_id)
    @profile.update(user_id: @id.user_id)
    @authorization.update(user_id: @id.user_id)
    @address.update(user_id: @id.user_id)
    sign_in(:user, @user)
    render :done
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

  def credit_params
    params.require(:credit).permit(:card_id, :limit_month, :limit_year, :security_code)
  end

end
=======
# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout 'devise'
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
>>>>>>> 19ba438... create sign_up
