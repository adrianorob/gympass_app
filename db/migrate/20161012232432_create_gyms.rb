class CreateGyms < ActiveRecord::Migration[5.0]
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :address
      t.float :longitude
      t.float :latitude
      t.string :open_time
      t.string :close_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
