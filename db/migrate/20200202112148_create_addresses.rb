class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name,         null: false, default: ""
      t.string :last_name,          null: false, default: ""
      t.string :first_name_kana,    null: false, default: ""
      t.string :last_name_kana,     null: false, default: ""
      t.string :zipcode, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :address_building
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
