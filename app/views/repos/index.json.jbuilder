json.array!(@repos) do |repo|
  json.extract! repo, 
  json.url repo_url(repo, format: :json)
end
