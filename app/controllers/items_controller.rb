class ItemsController < ApplicationController
  before_action :set_categories,:set_delivery
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new] 
  layout 'sell', except: [:index]
  def index
    @items = Item.all
  end

  def show
    @delivery = Delivery.find_by(item_id: @item)
    @items = Item.all
    # @deliveries = Delivery.all
    @images = Item.find_by(pictures: params[:pictures])
  end

  def new
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
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  # def set_delivery
  #   @delivery = Delivery.find_by(item_id: @item)
  # end

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