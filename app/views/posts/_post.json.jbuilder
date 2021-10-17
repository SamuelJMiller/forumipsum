json.extract! post, :id, :user_id, :thread_id, :body, :feedback_score, :is_banned, :created_at, :updated_at
json.url post_url(post, format: :json)
