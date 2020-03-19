require 'rails_helper'
require 'spec_helper'
require 'active_model'
describe Item do

  let(:image_path) { Rails.root.join('spec/fixtures/testsample.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  let(:item) { create(:item, :with_picture) }

  describe 'バリデーション' do

    it "画像、商品名、説明、カテゴリー、商品の状態、配送料の負担者、発送日、発送地域、値段が入力されていれば有効" do
      item
      expect(item).to be_valid
    end

    describe "未記入の場合" do
      it "画像無しは無効" do
        item = build(:item,pictures: nil)
        item.valid?
        expect(item.errors[:pictures]).to include("を入力してください")
      end
  
      it "商品名未記入は無効" do
        item = build(:item,name: nil)
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end

      it "商品説明未記入は無効" do
        item = build(:item,description: nil)
        item.valid?
        expect(item.errors[:description]).to include("を入力してください")
      end

      it "カテゴリーの選択無しは無効" do
        item = build(:item,category_id: nil)
        item.valid?
        expect(item.errors[:category_id]).to include("を入力してください")
      end
  
      it "商品状態の選択無しは無効" do
        item = build(:item,condition: nil)
        item.valid?
        expect(item.errors[:condition]).to include("を入力してください")
      end
  
      it "価格未記入は無効" do
        item = build(:item,price: nil)
        item.valid?
        expect(item.errors[:price]).to include("を入力してください")
      end

      it "サイズがnilだと無効" do
        item = build(:item,size: nil)
        item.valid?
        expect(item.errors[:size]).to include("を入力してください")
      end

    end

    describe "文字数の制限を超えた場合" do
      it "商品名が40文字以上は無効" do
        item = build(:item,name: "a" * 41)
        item.valid?
        expect(item.errors[:name]).to include("は40文字以内で入力してください")
      end

      it "商品名が1000文字以上は無効" do
        item = build(:item,
                      description: "a" * 1001)
        item.valid?
        expect(item.errors[:description]).to include("は1000文字以内で入力してください")
      end
    end

    describe "画像" do
      it "画像が2枚でも有効" do
        item = create(:item, pictures: [image, image])
        expect(item).to be_valid
      end
    
      it "画像が10枚でも有効" do
        item = create(:item, pictures: [image] * 10)
        expect(item).to be_valid
      end

      it "画像10枚以上は無効" do
        item = build(:item, pictures: [image] * 11)
        item.valid?
        expect(item.errors[:pictures]).to include("が登録できるのは10枚までです")
      end
    end




  end

  
end