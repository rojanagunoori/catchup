class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  #enum friend_status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: true
  #enum friend_status: { pending: 0, accepted: 1, rejected: 2 }
  #enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 }
  #enum friend_status: { none: 0, friends: 1, blocked: 2 }
  #enum status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: :status
  #enum friend_status: { requested: 0, confirmed: 1, blocked: 2 }, _prefix: :friend_status
  enum :status, { pending: 0, accepted: 1, rejected: 2 }, prefix: :status
  enum :friend_status, { requested: 0, confirmed: 1, blocked: 2 }, prefix: :friend_status


  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  #validates :friend_status, presence: true

  #validate :not_self, :not_duplicate

  after_initialize :set_default_status, if: :new_record?

  #scope :pending, -> { where(friend_status: "pending") }
   #scope :pending, -> { where(friend_status: :pending) }
   scope :pending, -> { where(status: :pending) }  # ✅ FIXED scope to use `status` instead of `friend_status`


  private

  def set_default_status
    self.friend_status ||= :requested  # Set default to `requested`
    #self.friend_status ||= :none  # ✅ FIXED default value (was `pending`, but `none` exists in `friend_status`)
    #self.friend_status ||= :pending
    #self.friend_status ||= 0

  end

  def not_self
    errors.add(:receiver, "You cannot send a request to yourself") if sender_id == receiver_id
  end

  def not_duplicate
    if FriendRequest.exists?(sender_id: sender_id, receiver_id: receiver_id)
      errors.add(:receiver, "Friend request already sent")
    end
  end

  def accept!
    update!(friend_status: :confirmed)  # Change to `confirmed`
    #update!(friend_status: :friends) # ✅ FIXED: Changed to `friends` (valid enum value)
    #update!(friend_status: 1) 
    #update!(friend_status: :accepted)
    sender.friendships.create!(friend: receiver)
    receiver.friendships.create!(friend: sender)

    #update(friend_status: :accepted)
    #sender.friendships.create!(friend: receiver)
    #receiver.friendships.create!(friend: sender)
  end
end
