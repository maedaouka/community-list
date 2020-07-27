json.extract! user, :id, :uid, :twitter_user_id, :created_at, :updated_at
json.url user_url(user, format: :json)
