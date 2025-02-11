# app/models/thought.rb
class Thought < ApplicationRecord
    belongs_to :user
    #has_many :reactions, dependent: :destroy  # Change to :likes if using "Like"
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    #validates :content, presence: true
  end
  

