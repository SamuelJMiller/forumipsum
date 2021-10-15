json.extract! forumthread, :id, :title, :replycount, :created_at, :updated_at
json.url forumthread_url(forumthread, format: :json)
