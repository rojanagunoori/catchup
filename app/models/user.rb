# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise :database_authenticatable, #:registerable,
         #:recoverable, :rememberable, :validatable
    has_secure_password
    validates :email, presence: true, uniqueness: true
    before_create :generate_authentication_token
    
    # Associations
    has_many :thoughts, dependent: :destroy
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships, source: :friend
    #has_many :sent_friend_requests, class_name: 'Friendship', foreign_key: 'user_id'
    #has_many :received_friend_requests, class_name: 'Friendship', foreign_key: 'friend_id'
    #has_many :friends, through: :sent_friend_requests, source: :friend
    has_many :friends, through: :friendships, source: :friend


    has_many :pending_requests, -> { where(status: "pending") }, class_name: "Friendship", foreign_key: "friend_id"
    has_many :friend_requests, through: :pending_requests, source: :user


    # Friend Requests
    has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'sender_id', dependent: :destroy
    has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'receiver_id', dependent: :destroy
    

    has_many :friends, class_name: "User", foreign_key: "friend_id"
    has_one_attached :profile_picture # If using Active Storage for image upload


    #has_many :reactions, dependent: :destroy  # Change to :likes if using "Like"
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    # Associations


    # Profile Picture (If using Active Storage)
    has_one_attached :profile_picture
    
    
    # Validations
    #validates :email, presence: true, uniqueness: true
    #validates :name,  presence: true
    #validates :name, presence: true
    validates :name, presence: true, allow_nil: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }, if: :password_required?



    def get_pending_friend_requests
      pending_friend_requests
    end

    def pending_friend_requests
      received_friend_requests.where(status: 'pending')
    end

    # ✅ Ensure this method is public by moving it above 'private'
     def public_pending_friend_requests
        received_friend_requests.where(status: "pending")
     end


     def send_friend_request(friend)
      friendships.create(friend: friend, status: "pending")
    end
  
    def accept_friend_request(user)
      friendship = pending_requests.find_by(user: user)
      friendship.update(status: "accepted") if friendship
    end
  
    def reject_friend_request(user)
      friendship = pending_requests.find_by(user: user)
      friendship.update(status: "rejected") if friendship
    end
  
    def remove_friend(friend)
      friendship = friendships.find_by(friend: friend) || friend.friendships.find_by(friend: self)
      friendship.destroy if friendship
    end

    def generate_password_reset_token!
      self.reset_password_token = SecureRandom.urlsafe_base64
      self.reset_password_sent_at = Time.zone.now
      save!
    end
    

    
    

    private

    def password_required?
      new_record? || password.present?
    end

    def generate_authentication_token
      self.authentication_token = SecureRandom.hex(10)
    end

    

   

    

    
  end
  

