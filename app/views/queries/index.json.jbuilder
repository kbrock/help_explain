json.array!(@queries) do |query|
  json.extract! query, :id, :name, :comment, :sql, :plan
  json.url query_url(query, format: :json)
end
