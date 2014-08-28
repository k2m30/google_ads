# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Country.destroy_all

Country.create(name: 'UK', proxy: '109.233.115.238:27463')
Country.create(name: 'USA', proxy: '209.239.112.95:2589')

Country.all.each do |country|
  ['ios app makers', "ios app makers in #{country.name}"].each do |query|
    Ad.create(body: query, country: country)
  end
end
