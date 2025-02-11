# app/models/thought.rb
class Thought < ApplicationRecord
    belongs_to :user
    
    validates :content, presence: true
  end
  

