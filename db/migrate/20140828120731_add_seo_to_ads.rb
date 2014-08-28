class AddSeoToAds < ActiveRecord::Migration
  def change
    add_column :ads, :seo, :boolean, default: false
  end
end
