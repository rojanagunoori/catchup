class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id, message: "Friend request already sent" }

  # Correct enum declaration in Rails 8
  enum status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: :status
end