class CreateItemsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string    :name, null: false,index: true
      t.text      :discription, null: false
      t.integer   :price, null: false
      t.integer   :size, null: false
      t.string    :status, null: false
      t.string    :pictures, null: false
      t.integer   :condition, null: false
      t.references :category
      t.references :buyer, foreign_key: { to_table: :users }
      t.references :seller, foreign_key: { to_table: :users }
    end
  end
end
