require 'rails_helper'
describe ItemsController do

  describe 'GET #new' do
    it "正しいビューに遷移する" do
      get :new
      expect(response).to render_template :new
    end
    it "@itemが期待される値を持つ" do
      get :show, params: { id: 1 }
    end

  describe 'Post #create' do
    context "@itemが保存出来た時" do
      it "データベースに値が保存される" do

        item = FactoryBot.create(:item, :with_picture)

        # get :show, params: { id: item }
      end
      it "商品詳細ページに遷移する" do
      end
    end
  end
  
    context "@itemが保存できなかった時" do
      it "データベースに値が保存されない" do
      end
      it "画面遷移しない(jp/sellにとどまる)" do
      end
    end


  end
  

end

