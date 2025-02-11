class Reaction < ApplicationRecord  # Rename to Like if you forced it
  belongs_to :user
  belongs_to :thought
end
