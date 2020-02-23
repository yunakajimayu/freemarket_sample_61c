class ItemsController < ApplicationController
  before_action :set_categories
  layout 'sell', except: [:index]
  def index
    @items = Item.all
  end

  def sell
    render :new
    @item = Item.new
  end

  def new
    @item = Item.new
    @item.build_delivery
  end

  def create
    item_params[:picture].each do |a|
      @item = Item.new(item_params.clone.merge({picture: a}))
      @item.save
    end
    redirect_to user_path
  end

  private

  def set_categories
    @categories = Category.all
  end

  def item_params
    params.require(:item).permit(
      :name, 
      :description,
      :price,
      :size,
      :status,
      :condition,
      :category_id,
      {picture: []},
      [:delivery_attributes],
      delivery_attributes:[
        :id,
        :delivery_status,
        :delivery_method,
        :delivery_area,
        :delivery_day,
        :postage,
        :postage_bearer]
      )
      .merge(seller_id: current_user.id,buyer_id: nil)
  end



end

