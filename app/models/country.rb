class Country < ActiveRecord::Base
  has_many :ads, dependent: :destroy
end
