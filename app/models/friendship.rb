# app/models/friendship.rb
class Friendship < ApplicationRecord
    belongs_to :user      # the one who sent the request
    belongs_to :friend, class_name: 'User'
    
    # status: pending, accepted, rejected
    validates :status, inclusion: { in: %w[pending accepted rejected] }
  end
  

