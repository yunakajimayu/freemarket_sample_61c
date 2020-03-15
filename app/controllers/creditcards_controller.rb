class CreditcardsController < ApplicationController
  require "payjp"
  before_action :set_credit
  
  def index  #登録しているカードデータを表示
    if @credit.present?  #creditテーブルの情報をpayjpに送り、カード情報を取得する
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@credit.customer_id)
      @card_information = customer.cards.retrieve(@credit.card_id)

      @card_brand = @card_information.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.svg"
      when "JCB"
        @card_src = "jcb.svg"
      when "saison-card"
        @card_src = "saison-card.svg"
      when "MasterCard"
        @card_src = "master-card.svg"
      when "American Express"
        @card_src = "american_express.svg"
      when "Diners Club"
        @card_src = "dinersclub.svg"
      when "Discover"
        @card_src = "discover.svg"
      end
    end
    render layout: 'creditcards'
  end
  

  def new #カード登録画面
    credit = Credit.where(user_id: current_user.id).first
    redirect_to action:"index" if @credit.present?
  end

  def create #PayjpとCreditのDBを作成
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    #"payjp_token"を受け取れればカード情報を登録、なければnewする
    if params['payjp-token'].blank?
      redirect_to action:"new"
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token']
      )
      @credit = Credit.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def destroy #payjpとcreditデーブルの削除
    if @credit.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]  #payjpにCreditデータを送る
      customer = Payjp::Customer.retrieve(@credit.customer_id)  #返ってくるデータを取得
      customer.delete
      @credit.delete
      if @credit.destroy
        redirect_to action: "index", alert: "削除しました"
      else
        redirect_to action: "index", alert: "削除できませんでした"
      end
    end
  end

  private

  def set_credit #現在のユーザーのCredit情報を取得
    @credit = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).exists?
  end

end
