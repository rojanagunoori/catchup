class Friendship < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # Validations
  validates :user_id, uniqueness: { scope: :friend_id, message: "Friend request already sent" }

  # Enum for friendship status
  enum status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: true
  #enum status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: :status
end