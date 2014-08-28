# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Country.destroy_all

Country.create(name: 'UK')
Country.create(name: 'USA')

Country.all.each do |country|
  ['ios app makers', 'ios app makers in uk'].each do |query|
    Ad.create(body: query, country: country)
  end
end
