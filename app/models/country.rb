class Country < ActiveRecord::Base
  has_many :ads, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
