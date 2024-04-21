class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :title, :content, presence: true

  has_many :comments, dependent: :destroy
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
end
