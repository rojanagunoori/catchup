class Like < ApplicationRecord
  belongs_to :user
  belongs_to :comment, counter_cache: :likes_count, optional: true
  belongs_to :thought, optional: true # Fixed syntax error here!
end
