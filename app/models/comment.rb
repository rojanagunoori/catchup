class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :thought
  has_many :likes, dependent: :destroy
end
