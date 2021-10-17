class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  # All devise modules are enabled in the database migration file

  # Make sure username is unique and handle name conflicts gracefully
  validates_uniqueness_of :username

  # Threads/posts association
  has_many :forumthreads
  has_many :posts
end
