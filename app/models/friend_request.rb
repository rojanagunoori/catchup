# app/models/friend_request.rb
class FriendRequest < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'


    validates :sender_id, presence: true
    validates :receiver_id, presence: true
    validate :not_self, :not_duplicate
  
    # Default status for new requests is 'pending'
    after_initialize :set_default_status, if: :new_record?

    # Define a scope for pending friend requests
    scope :pending, -> { where(status: "pending") }
  
    private
  
    def set_default_status
      self.status ||= 'pending'
    end


    def not_self
      errors.add(:receiver, "You cannot send a request to yourself") if sender_id == receiver_id
    end
  
    def not_duplicate
      if FriendRequest.exists?(sender_id: sender_id, receiver_id: receiver_id)
        errors.add(:receiver, "Friend request already sent")
      end
    end
  end
  