# app/models/user.rb
class User < ApplicationRecord
    has_secure_password
    
    # Associations
    has_many :thoughts, dependent: :destroy
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships

    #has_many :reactions, dependent: :destroy  # Change to :likes if using "Like"
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    
    # Validations
    #validates :email, presence: true, uniqueness: true
    #validates :name,  presence: true
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }

  end
  

