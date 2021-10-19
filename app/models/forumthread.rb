class Forumthread < ApplicationRecord
    belongs_to :user
    has_many :posts, dependent: :destroy

    validates :title, presence: true, allow_blank: false
end
