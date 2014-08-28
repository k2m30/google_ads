class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :body
      t.belongs_to :country

      t.timestamps
    end
  end
end
