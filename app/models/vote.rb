class Vote < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :post
  belongs_to :comment
end
