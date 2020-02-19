class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.integer :card_id, null: false
      t.integer :limit_month, null: false
      t.integer :limit_year, null: false
      t.integer :security_code, nul: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
