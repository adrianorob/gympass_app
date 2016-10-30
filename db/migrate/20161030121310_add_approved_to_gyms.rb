class AddApprovedToGyms < ActiveRecord::Migration[5.0]
  def change
    add_column :gyms, :approved, :boolean, default: false
  end
end
