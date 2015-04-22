json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :filedownload_id, :data
  json.url comment_url(comment, format: :json)
end
