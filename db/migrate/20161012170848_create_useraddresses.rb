class CreateUseraddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :useraddresses do |t|
      t.references :user, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.string :address

      t.timestamps
    end
  end
end
