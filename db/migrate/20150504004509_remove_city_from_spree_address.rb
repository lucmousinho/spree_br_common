class RemoveCityFromSpreeAddress < ActiveRecord::Migration[4.2]
  def change
    remove_column :spree_addresses, :city, :string
  end
end
