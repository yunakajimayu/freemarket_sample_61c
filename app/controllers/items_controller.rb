class ItemsController < ApplicationController
  before_action :set_categories
  def index
    @items = Item.all
  end

  def sell

  end

  def new
    render layout: 'sell' 
    @item = Item.new
    @item.build_delivery
  end

  def create
    binding.pry
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
    params.require(:item).permit(
      :name, 
      :description,
      :prefecture,
      :price,
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
      .merge(seller_id: current_user.id,size: 0,status: 0,delivery_id: 0)
  end



end

