class ItemsController < ApplicationController
  def index
  end

  def sell
    render layout: 'sell'
  end
end
