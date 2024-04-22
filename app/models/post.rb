class Post < ApplicationRecord
  belongs_to :user

  validates :title, :content, presence: true

  has_many :comments, dependent: :destroy
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables

  def associate_tags(tags)
    self.taggables.destroy_all
    tags = tags.strip.gsub(' ', '').split(',').reject {|el| el == ''}
    tags.each do |tag|
      self.tags << Tag.find_or_create_by(name: tag)
    end
  end
end
