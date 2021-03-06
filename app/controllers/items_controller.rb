class ItemsController < ApplicationController
  before_action :set_categories,:set_delivery
  before_action :set_item, only: [:show, :edit, :update, :destroy, :transaction, :done]
  before_action :authenticate_user!, only: [:new] 
  layout 'sell', except: [:index]
  def index
    # トップページの各カテゴリの商品情報を新着順に10件まで取り出します。category_idの割り振りはテキトーですので、商品出品が完成次第変更させます。
    # ↓シャネルの新着商品10件
    @chanels = Item.includes(:user).where(category_id: 1, buyer_id: nil).limit(10).order("created_at DESC")
    # ↓ルイヴィトンの新着商品10件
    @louisvuittons =Item.includes(:user).where(category_id: 2, buyer_id: nil).limit(10).order("created_at DESC")
    # ↓シュプリームの新着商品10件
    @supremes = Item.includes(:user).where(category_id: 3, buyer_id: nil).limit(10).order("created_at DESC")
    # ↓ナイキの新着商品10件
    @nikes= Item.includes(:user).where(category_id: 4, buyer_id: nil).limit(10).order("created_at DESC")
    # ↓レディースの新着商品10件
    @women = Item.includes(:user).where(category_id: 5, buyer_id: nil).limit(10).order("created_at DESC")
    # ↓メンズの新着商品10件
    @mens = Item.includes(:user).where(category_id: 6, buyer_id: nil).limit(10).order("created_at DESC")
    # ↓家電・スマホ・カメラの新着商品10件
    @electricitems = Item.includes(:user).where(category_id: 7, buyer_id: nil).limit(10).order("created_at DESC")
    # ↓おもちゃ・ホビー・グッズの新着情報10件
    @hobbies = Item.includes(:user).where(category_id: 8, buyer_id: nil).limit(10).order("created_at DESC")

  end

  def done

  end

  def edit
    @delivery = Delivery.find_by(item_id: @item)
  end

  def update
    if @item.seller_id == current_user.id && @item.update(item_params)
      redirect_to action: "show"
    else
      render :edit
    end
  end

  def show
    @delivery = Delivery.find_by(item_id: @item)
    @items = Item.all
    @deliveries = Delivery.all
    @images = Item.find_by(pictures: params[:pictures])
  end

  def purchase
    @item = Item.find(params[:id])
    @credit = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).exists?
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    Payjp::Charge.create(
      amount: @item.price, # 決済する値段
      customer: @credit.customer_id, # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
    @item.update(buyer_id: current_user.id)
    @buyer = Address.find_by(user_id: current_user.id)
    render :done
  end

  def sell
    @item = Item.new
    @item.build_delivery
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :sell }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def transaction
    @credit = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).exists?
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
    @buyer = Address.find_by(user_id: current_user.id)
  end

  def show
    @user = User.find(@item.seller_id)
    @categories = Category.find(@item.category_id)
    @deliveries = @item.delivery
  end

  def destroy
    if @item.seller_id == current_user.id
      @item.destroy 
      redirect_to root_path
    else
      flash[:notice] = "削除に失敗しました"
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def set_delivery
    @delivery = Delivery.find_by(item_id: @item)
  end

  def item_params
    params.require(:item).
    permit( :name, 
            :description,
            :price,
            :size,
            :status,
            :condition,
            :category_id,
            {pictures: []},
            [:delivery_attributes],
              delivery_attributes:[
                :id,
                :delivery_status,
                :delivery_method,
                :delivery_area,
                :delivery_day,
                :postage,
                :postage_bearer]).
    merge(seller_id: current_user.id,buyer_id: nil)
  end

end