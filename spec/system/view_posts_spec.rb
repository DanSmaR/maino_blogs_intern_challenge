require 'rails_helper'

describe 'User views posts' do
  context 'as visitant' do
    it 'successfully' do
      post_author1 = User.create!(
        name: "MariaTeste", email: "mariateste@email.com", password: 123456
      )
      post_author2 = User.create!(
        name: "JoaoTeste", email: "joaoteste@email.com", password: 123456
      )

      2.times do |i|
        post_author1.posts.create!(
          title: "Publicação #{i + 1}", content: "Esse é o conteúdo incrível da minha publicação #{i + 1}"
        )
      end

      post_author2.posts.create!(title: "Publicação 3", content: "Esse é o conteúdo incrível da minha publicação 3")

      visit root_path

      expect(page).to have_content("Publicações")

      3.times do |i|
        expect(page).to have_content("Publicação #{3 - i}")
        expect(page).to have_content("Esse é o conteúdo incrível da minha publicação #{3 - i}")
      end

      expect(page).to have_ordered_text("Publicação 3", "Publicação 2", "Publicação 1")
    end
  end
end