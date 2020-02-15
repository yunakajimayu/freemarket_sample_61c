class ItemsController < ApplicationController
  before_action :set_categories
  def index
    @items = Item.all
  end

  def sell
    
    

  end

  def new
    render 'sell',layout: 'sell' 
    @item = Item.new
  end

  def create

    @item = Item.new(create_params)
    binding.pry
    if @item.save
      redirect_to @item
    else

      render root
    end


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

