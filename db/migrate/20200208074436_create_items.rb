class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,null: false,index: true
      t.text :description, null: false
      t.string :prefecture, null: false
      t.integer :price, null: false
      t.integer :size, null: false
      t.string :status, null: false
      t.string :picture, null: false
      t.integer :condition, null: false
      t.timestamps
    end
  end
end
