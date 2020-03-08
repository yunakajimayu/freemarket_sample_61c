class ItemsController < ApplicationController
  before_action :set_categories
  layout 'sell', except: [:index]
  def index
    @items = Item.all
  end

  def sell
    render :new
  end

  def purchase
    @credit = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).exists?
    Payjp.api_key = "sk_test_06207c0e157a821b64f2bcdc"
    Payjp::Charge.create(
      amount: 5400, # 決済する値段
      customer: @credit.customer_id, # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
    redirect_to action: "done"
  end

  def new
    @item = Item.new
  end

  def create

    @item = Item.new(create_params)
    if @item.save
      redirect_to @item
    else

      render root
    end


  end

  def transaction
    @credit = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).exists?
    if @credit.present?  #creditテーブルの情報をpayjpに送り、カード情報を取得する
      Payjp.api_key = "sk_test_06207c0e157a821b64f2bcdc"
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
  end

  private

  def set_categories
    @categories = Category.all
  end

  def create_params
    params.require(:item).permit(:name, :description,:price,:postage,:picture,:condition,:category_id).merge(seler_id: current_user.id)
  end

end