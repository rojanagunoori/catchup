class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id, message: "Friend request already sent" }

  # Enum definition
  #enum friendship_status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: true
  #enum status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: true
  #enum status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: :status
  enum :status, { pending: 0, accepted: 1, rejected: 2 }, prefix: :status


end
