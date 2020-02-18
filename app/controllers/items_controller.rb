class ItemsController < ApplicationController
  before_action :set_categories
  layout 'sell', except: [:index]
  def index
    @items = Item.all
  end

  def sell
    render :new
  end

  def new
    @item = Item.new
    @item.build_delivery
  end

  def create
    size = "aaa"
    @item = Item.new(item_params[:delivery_attributes])
    
    if @item.save
      format.html { redirect_to sell_items_path, notice: 'Book was successfully created.' }
      format.json { render :new, status: :created, location: @item }
    else
      format.html { redirect_to sell_items_path }
      format.json { render json: @item.errors, status: :unprocessable_entity }
    end


  end

  private

  def set_categories
    @categories = Category.all
  end

  def item_params
    params.permit(
      :name, 
      :description,
      :prefecture,
      :price,
      :size,
      :status,
      :condition,
      :category_id,
      {picture: [:picture]},
      delivery_attributes:[
        :id,
        :delivery_day,
        :delivery_status,
        :delivery_method,
        :postage,
        :postage_bearer]
      )
      .merge(seller_id: current_user.id)
  end

end

