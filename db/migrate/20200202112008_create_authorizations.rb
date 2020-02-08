class CreateAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :authorizations do |t|
      t.integer :authorization_number, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
