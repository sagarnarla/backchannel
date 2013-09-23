class User < ActiveRecord::Base
  has_many :categories
  has_many :posts
  has_many :comments
  has_many :votes

  validates :username, :presence => true
  validates :password, :presence => true
  validates :nickname, :presence => true
 # attr_accessible :nickname, :password, :user_type, :username
end
