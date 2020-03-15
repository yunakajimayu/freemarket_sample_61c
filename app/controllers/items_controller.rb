class ItemsController < ApplicationController
  before_action :set_categories
  layout 'sell', except: [:index]
  def index
    @items = Item.all
  end

  def sell
    render :new
  end

  def edit
    @items = Item.find(1)
  #   #gem gonを使って変数をJavascriptのファイルと連動させる。
  #   gon.item = @items
  #   gon.item_pictures = @items.item_pictures

  #   require 'base64'
  #   require 'aws-sdk'

  #   #S3に保存している画像データを呼び出す
  #   gon.item_pictures_binary_datas = []
  #   if Rails.env.production?
  #     client = Aws::S3::client.new(
  #                           region: 'ap-northeast-1',
  #                           access_key_id: Rails.application.credentials.aws[:access_key_id],
  #                           secret_access_key: Rails.application.credentials.aws[:secret_access_key],
  #                           )
  #     @item.item_pictures.each do |picture|
  #       binary_data = client.get_object(bucket: 'freemarket61c',key: pictures.pictures_url.file.path).body.read
  #       gon.item_images_binary_datas << Base64.strict_encode64(binary_data)
  #     end
  #   end
  end

  def update
    #ブランド名がstringでparamsに入ってくるので、id番号に書き換え
    if brand = Brand.find_by(name: params[:item][:brand_id])
      params[:item][:brand_id] = brand.id
    else
      params[:item][:brand_id] = Brand.create(name: params[:item][:brand_id]).id
    end

    @item = Item.find(params[:id])

    #登録済画像のidの配列を生成
    ids = @item.item_pictures.map{|pictures| picures.id }
    #登録済画像のうち、編集後もまだ残っている画像のidの配列を生成(文字列から数値に変換)
    exist_ids = registered_pictures_params[:ids].map(&:to_i)
    #登録済画像が残っていない場合(配列に0が格納されている)、配列を空にする
    exist_ids.clear if exist_ids[0] == 0

    if (exist_ids.length != 0 || new_pitures_params[:pictures][0] !=" ") && @item.update(item_params)
    
      unless ids.length == exist_ids.length
        delete_ids = ids - exist_ids
        delete_ids.each do |id|
          @item.item_pictures.find(id).destroy
        end
      end

      unless new_pictures_params[:pictures][0] == " "
        new_pictures_params[:pictures].each do |pictures|
          @item.item_pictures.create(pictures_url: image, pictures_id: @item.id)
        end
      end

      flash[:notice] = "編集が完了しました"
      redirect_to item_path(@item), data: {tubolinks: false}

    else
      flash[:alert] = "未入力項目があります"
      redirect_back(fallback_location: root_path)
    end

  end

  def new
    @item = Item.new
  end

  def create

    @item = Item.new(create_params)
    if @item.save
      redirect_to @item
    else

      render root
    end


  end

  def transaction
    render layout: 'sell'
  end 

  private

  def set_categories
    @categories = Category.all
  end

  private

  def create_params
    params.require(:item).permit(:name, :description,:price,:postage,:picture,:condition,:category_id).merge(seler_id: current_user.id)
  end

  def edit
    params.require(:item).permit(:name, :description,:price,:postage,:picture,:condition,:category_id).merge(seler_id: current_user.id)
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :size, :buyer_id, :postage_bearer, :delivery_area, :delivery_day, :price)
  end

  def registered_pictures_params
    params.require(:registered_pictures_ids).permit({ids: []})
  end

  def new_pictures_params
    params.require(:new_pictures).permit({pictures: []})
  end

end

