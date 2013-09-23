class Post < ActiveRecord::Base
#  attr_accessible :content
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :votes

  validates :user, :presence => true
  validates :category, :presence => true
  validates :content, :presence => true
end