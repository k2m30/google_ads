json.array!(@ads) do |ad|
  json.extract! ad, :id, :body
  json.url ad_url(ad, format: :json)
end
