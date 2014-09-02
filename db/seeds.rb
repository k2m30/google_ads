Country.destroy_all
Country.create(name: 'UK', proxy: '109.233.115.238:27463')
Country.create(name: 'USA', proxy: '192.241.158.23:1080')

queries = ['ios app makers',
         # 'ios app makers in UK',
         # 'ios app makers in USA',
         # 'making an Android app',
         # 'Android app makers',
         # 'Android app Making',
         # 'Android application maker',
         # 'Android app Developers',
         # 'Android app Developer company',
         # 'Android app Developer service',
         # 'Android application Developers',
         # 'Android app design company',
         # 'Android app design',
         # 'Android application design',
         # 'app builders',
         # 'application builders',
         # 'application builder company',
         # 'app builder company',
         # 'make an iPad app',
         # 'making an iPad app',
         # 'Mobile app design',
         # 'Mobile app design services',
         # 'Mobile application design service',
         # 'application makers',
         # 'corporate application design',
         # 'enterprise application design',
         # 'make an app',
         # 'application Developer services',
         # 'make an iPhone application',
         # 'iphone app development',
         # 'corporate iphone app developer',
         # 'enterprise iphone app developer',
         # 'iPad app design',
         # 'iPad application Developers',
         # 'application design agency',
         # 'application design company',
         'app development']

Country.all.each do |country|
  queries.each do |query|
    Ad.create(body: query, country: country)
  end
end
