require 'rails_helper'

describe ItemsController do
  describe 'GET #index' do
    it "populates an array of chanels ordered by created_at DESC" do
      chanels = create_list(:item, 3) 
      get :index
      expect(assigns(:chanels)).to match(chanels.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "renders the :index template" do
    end
  end
end