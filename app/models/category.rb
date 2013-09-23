class Category < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  validates :user, :presence => true
  validates :name, :presence=>true
  #attr_accessible :name
end
