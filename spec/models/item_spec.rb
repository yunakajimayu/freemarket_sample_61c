require 'rails_helper'
describe Item do
  include CarrierWave::Test::Matchers

  before do
    @uten = FactoryBot.create(:item)
    @item.pictures.store!(File.open('spec/fixtures/testsample.jpg'))
  end

  describe '#create' do
    it "picture fileが存在するか" do
      @picture.remove_file!
      assert_not @picture.valid?
    end

    it "画像無しは無効/is invalid without a picture" do
      item = build(:item,pictures: nil)
      item.valid?
      expect(item.errors[:pictures]).to include("を入力してください")
    end

    it "商品名未記入は無効/is invalid without a name" do
      item = build(:item,name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品名が40文字以上は無効/is invalid with a name that has more than 40 characters" do
      item = build(:item,name: "商品名が４０文字以上の場合は無効になるよ商品名が４０文字以上の場合は無効になるよああああ")
      item.valid?
      expect(item.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "商品説明未記入は無効/is invalid without a description" do
      item = build(:item,description: nil)
      item.valid?
      expect(item.errors[:description]).to include("を入力してください")
    end

    it "商品名が1000文字以上は無効/is invalid with a description that has more than 1000 characters" do
      item = build(:item,
                    description: "スーツケースを格安で購入する場合、皆さんならまずスーツケースのどの部分を見ますか？
                    スーツケースを選ぶ際に抑えておきたいポイントは「デザイン」「重さ」「大きさ」「ブランド」の4つです。
                    格安で購入するためにはその4つのポイントのどの点を妥協するか、ということになります。まずは、4つの
                    ポイントをそれぞれ説明しましょう。
                    1つ目のデザインに関してです。正直デザインに関しては、人それぞれなので、何がよい、悪いを一概に判断する
                    事は出来ません。しかしデザインに関しては大きく2種類に分類する事が出来ます。それは閉じる部分がチャック
                    式になってるかなっていないかです。これは容量とも関係する部分ですが、ここはデザインの大きな要素です。
                    カチッとしたデザインが好きであればチャックは選びませんが、カジュアルなイメージであれば、チャック式
                    ということになるでしょう。色や柄は自分の好きなものを選ぶのが、愛着も沸いてよいと思いますが、一番最初
                    に見るポイントとしてまずここは覚えておきたいところです。
                    2つ目は重さです。重さは非常に重要です。なぜなら、飛行機には預け入れ荷物の重量制限があり、これを
                    オーバーすると超過料金を支払う必要があるためです多くの空港会社は20キロ前後が制限になっています。
                    それを逆算して大きさにもよりますが、大きいものでも4キロ程度の軽めのスーツケースを買うのが得策かと
                    思います。但し、大きくても軽いスーツケースは比較的値段が高いものが多く、格安で購入したいニーズには
                    合わないかもしれません。
                    3つ目は大きさです。重さと連動する点でもありますが、容量は大きく分けると5種類程度に分けられます。
                    小さいものから、SS、S、M、L、LLです。スーツケースを必要とする時期や旅先の滞在期間に応じて購入する
                    ようにしましょう。当然、大きくなればなるほど、値段も高くなります。
                    4つ目はブランドです。正直高いスーツケースは本当に高いです。100万を超えるようなスーツケースも
                    ざらにあります。良いブランドであれば当然機能性やデザイン性には優れていますが、格安で購入するので
                    あれば、あまり名の知られていないブランドのスーツケースを買うことをおすすめします。但し長い目で見ると、 頻繁に使うのであればよいもの1つ買って長く使ったほうが、コスパがよいかも知れません。
                    以上のポイントから、何を妥協すべきか、妥協できるのかを考えて購入すると、
                    自分にあったお得な格安スーツケースが購入できるでしょう。")
      item.valid?
      expect(item.errors[:description]).to include("は1000文字以内で入力してください")
    end

    it "カテゴリーの選択無しは無効/is invalid without a category_id" do
      item = build(:item,category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    it "商品状態の選択無しは無効/is invalid without a condition" do
      item = build(:item,condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end

    it "価格未記入は無効/is invalid without a price" do
      item = build(:item,price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "サイズがnilだと無効/is valid without a size" do
      item = build(:item,size: nil)
      item.valid?
      expect(item.errors[:size]).to include("を入力してください")
    end


  end

  
end