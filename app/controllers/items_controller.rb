class ItemsController < ApplicationController
  before_action :set_categories
  layout 'sell', except: [:index]
  def index
    # トップページの各カテゴリの商品情報を新着順に10件まで取り出します。category_idの割り振りはテキトーですので、商品出品が完成次第変更させます。
    # ↓シャネルの新着商品10件
    @chanels = Item.includes(:user).where(category_id: 1).limit(10).order("created_at DESC")
    # ↓ルイヴィトンの新着商品10件
    @louisvuitton =Item.includes(:user).where(category_id: 2).limit(10).order("created_at DESC")
    # ↓シュプリームの新着商品10件
    @supreme = Item.includes(:user).where(category_id: 3).limit(10).order("created_at DESC")
    # ↓ナイキの新着商品10件
    @nike= Item.includes(:user).where(category_id: 4).limit(10).order("created_at DESC")
    # ↓レディースの新着商品10件
    @women = Item.includes(:user).where(category_id: 5).limit(10).order("created_at DESC")
    # ↓メンズの新着商品10件
    @mens = Item.includes(:user).where(category_id: 6).limit(10).order("created_at DESC")
    # ↓家電・スマホ・カメラの新着商品10件
    @electricitem = Item.includes(:user).where(category_id: 7).limit(10).order("created_at DESC")
    # ↓おもちゃ・ホビー・グッズの新着情報10件
    @hobby = Item.includes(:user).where(category_id: 8).limit(10).order("created_at DESC")

  end

  def sell
    render :new
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
    render layout: 'sell'
  end 

  private

  def set_categories
    @categories = Category.all
  end

  private

  def create_params
    params.require(:item).permit(:name, :description,:price,:postage,:picture,:condition,:category_id).merge(seler_id: current_user.id)
  end

end

