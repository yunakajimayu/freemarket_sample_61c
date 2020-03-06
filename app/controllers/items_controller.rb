class ItemsController < ApplicationController
  before_action :set_categories
  require 'payjp'
  
  def index
    @items = Item.all
  end

  def sell
    render layout: 'sell'
    @item = Item.new
  end

  def purchase
    # @price = Item.price
    Payjp.api_key = "sk_test_06207c0e157a821b64f2bcdc"
    Payjp::Charge.create(
      amount: 4000, # 決済する値段
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
  end

  def create
  end

  private

  def set_categories
    @categories = Category.all
  end

end

