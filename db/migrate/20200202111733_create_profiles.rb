class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.text :profile, null: true
      t.string :profile_image, null: true
      t.integer :tell_number,   null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
