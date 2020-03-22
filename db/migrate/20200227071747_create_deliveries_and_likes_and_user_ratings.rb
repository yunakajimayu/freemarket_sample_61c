class CreateDeliveriesAndLikesAndUserRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.string :delivery_day ,null: false
      t.string :delivery_status,null: false
      t.string :delivery_method,null: false
      t.integer :postage,null: false
      t.string :postage_bearer,null: false
      t.references :item,foreign_key: true
      t.string :delivery_area,null: false

      t.timestamps
    end

    create_table :likes do |t|
      t.string :like_count 
      t.references :user,null: false,foreign_key: true
      t.references :item,null: false,foreign_key: true

      t.timestamps
    end

    create_table :user_ratings do |t|
      t.integer :rating_by_saler
      t.integer :rating_by_buyer
      t.references :item, foreign_key: true

      t.timestamps
    end

    add_reference :items, :like
    add_reference :items, :user_rating

    
  end
end