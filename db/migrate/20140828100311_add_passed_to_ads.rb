class AddPassedToAds < ActiveRecord::Migration
  def change
    add_column :ads, :passed, :boolean, default: false
  end
end
