class CreditcardsController < ApplicationController
  layout false
  def index
    render layout: 'creditcards'
  end

  def credit
    render layout: 'creditcards'
  end
end
