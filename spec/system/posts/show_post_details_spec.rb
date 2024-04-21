require 'rails_helper'

describe 'User view post details' do
  context 'as visitant' do
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

      last_post = Post.last

      visit root_path
      click_link href: post_path(last_post)

      expect(page).to have_current_path("/posts/#{last_post.id}")
      expect(page).to have_content("Detalhes da Publicação")
      expect(page).to have_content("Publicado por Maria")
      expect(page).to have_content("Publicação 2")
      expect(page).to have_content("Esse é o conteúdo incrível da minha publicação 2")
      expect(page).to have_content('Tags: #ruby #rails', count: 1)
      expect(page).to have_link('#ruby', href: tag_path(Tag.first))
      expect(page).to have_link('#rails', href: tag_path(Tag.last))
    end
  end
end