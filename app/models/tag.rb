class Tag < ApplicationRecord
  has_many :taggables
  has_many :posts, through: :taggables

  validates :name, uniqueness: true
end
