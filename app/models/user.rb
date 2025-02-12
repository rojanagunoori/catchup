# app/models/user.rb
class User < ApplicationRecord
    has_secure_password
    before_create :generate_authentication_token
    
    # Associations
    has_many :thoughts, dependent: :destroy
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships, source: :friend



    has_many :friends, class_name: "User", foreign_key: "friend_id"
    has_one_attached :profile_picture # If using Active Storage for image upload


    #has_many :reactions, dependent: :destroy  # Change to :likes if using "Like"
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    
    # Validations
    #validates :email, presence: true, uniqueness: true
    #validates :name,  presence: true
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

    private

    def password_required?
      new_record? || password.present?
    end

    def generate_authentication_token
      self.authentication_token = SecureRandom.hex(10)
    end

  end
  

