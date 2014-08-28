class AddProxyToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :proxy, :string
  end
end
