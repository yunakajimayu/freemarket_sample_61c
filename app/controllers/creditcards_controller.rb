class CreditcardsController < ApplicationController
  require "payjp"
  # before_action :set
  layout false

  def new #カード登録画面
    credit = Credit.where(user_id: current_user.id)
    redirect_to action:"show" if credit.exists?
  end

  def pay #PayjpとCreditのDBを作成
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    #"payjp_token"を受け取れればカード情報を登録、なければnewする
    if params['payjp-token'].blank?
      redirect_to action:"new"
    else
      customer = Payjp::Customer.create(
        description: '登録テスト', #PAY.JPの顧客情報に表示する。
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @credit = Credit.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #payjpとcreditデーブルの削除
    credit = Credit.where(user_id: current_user.id).first  #idを取り出す
    if credit.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]  #payjpにCreditデータを送る
      customer = Payjp::Customer.retrieve(credit.customer_id)  #返ってくるデータを取得
      customer.delete
      credit.delete
    end
  end

  def show #Creditのデータをpayjpに送り情報を取り出す
    credit = Credit.where(user_id: current_user.id).first
    if credit.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(credit.customer_id)
      @default_card_information = customer.credit.retrieve(credit.credit_id)
    end
  end

  private

  # def set
  #   @credit = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).exists?
  # end

end