class Post < ApplicationRecord
    belongs_to :user
    belongs_to :forumthread

    validates :body, presence: true, allow_blank: false
end
