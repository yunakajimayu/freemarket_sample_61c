require 'rails_helper'
RSpec.describe "Items", type: :request do
  let(:user) { create(:user) }
  let(:image_path) { Rails.root.join('spec/fixtures/testsample.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) } # ファイルアップロードのテスト用のクラス
  let(:item_create) { create(:item, :with_picture) }

  describe 'GET #new' do
    context "log in" do
      login
      it "正しいビュー(/jp/sell)に遷移する" do
        get "/jp/sell" #request specはパスを直叩きする必要がある
        expect(response).to render_template :new
      end
    end
  end

  describe 'Post #create' do
    context "log in" do
      login
      context "can save" do
        it "値がデータベースに保存される" do
          item_create
          expect(item_create).to be_valid
        end

        it "@itemが期待される値を持つ" do
          item_create
          get "/jp/#{item_create.id}", params: { id: item_create }
          expect(assigns(:item)).to eq item_create
        end

        it 'itemモデルのレコード総数が1増える' do
          expect{ item_create }.to change(Item, :count).by(1)
        end

        it "商品詳細ページに遷移する" do
          item_create
          get "/jp/#{item_create.id}", params: { id: item_create }
          expect(response).to render_template :show
        end
      end

      context "can not save" do
        let(:invalid_params) {{item: attributes_for(:item, :with_picture,name: nil)}}
        subject {
          post "/jp/",
          params: invalid_params
        }

        it 'itemモデルのレコード総数が増えない' do
          expect{ subject }.not_to change(Item, :count)
        end

        it "画面遷移しない(jp/sellにとどまる)" do
          subject
          expect(response).to render_template :new
        end
      end
    end

    context "Not log in" do
      it "商品出品ページ(Newアクション)を表示できない" do
        get "/jp/sell"
        expect(response).not_to render_template :new
      end
      it "商品出品ページへアクセスすると新規登録画面にリダイレクトされる" do
        get "/jp/sell"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end