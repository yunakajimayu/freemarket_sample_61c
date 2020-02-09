class ItemsController < ApplicationController
  before_action :set_categories
  def index
    @items = Item.all
  end

  def sell
    render layout: 'sell'
    @item = Item.new
  end

  def new
  end

  def create
  end

  private

  def set_categories
    @categories = Category.all
  end

end

