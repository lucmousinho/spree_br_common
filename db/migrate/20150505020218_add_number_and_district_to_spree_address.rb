class AddNumberAndDistrictToSpreeAddress < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_addresses, :number, :integer
    add_column :spree_addresses, :district, :string
  end
end
