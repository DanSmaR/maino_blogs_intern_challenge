require 'rails_helper'

describe 'User view posts by tag' do
  context 'when logged off' do
    it 'successfully' do
      post_author1 = User.create!(
        name: "Maria", email: "mariateste@email.com", password: 123456
      )

      2.times do |i|
        post = post_author1.posts.create!(
          title: "Publicação #{i + 1}", content: "Esse é o conteúdo incrível da minha publicação #{i + 1}"
        )
        post.tags << Tag.find_or_create_by(name: 'ruby')
        post.tags << Tag.find_or_create_by(name: 'rails')
      end

      4.times do |i|
        post = post_author1.posts.create!(
          title: "Publicação #{i + 3}", content: "Esse é o conteúdo incrível da minha publicação #{i + 3}"
        )
        post.tags << Tag.find_or_create_by(name: 'sql')
        post.tags << Tag.find_or_create_by(name: 'database')
      end

      tag = Tag.find_by(name: 'sql')

      visit post_path(tag.posts.last)
      click_link 'sql'

      expect(page).to have_current_path tag_path(tag)
      expect(page).to have_content 'Tag: sql'

      Post.limit(3).order(created_at: :desc).each do |post|
        expect(page).to have_content post.title
        expect(page).to have_content post.content
        expect(page).to have_content "Tags: ##{post.tags.first.name} ##{post.tags.last.name}"
      end
    end
  end
end