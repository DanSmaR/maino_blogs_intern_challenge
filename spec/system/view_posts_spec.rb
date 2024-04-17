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

      5.times do |i|
        post_author1.posts.create!(
          title: "Publicação #{i + 1}", content: "Esse é o conteúdo incrível da minha publicação #{i + 1}"
        )
        end

      4.times do |i|
        post_author2.posts.create!(
          title: "Publicação #{i + 6}", content: "Esse é o conteúdo incrível da minha publicação #{i + 6}"
        )
      end

      visit root_path

      expect(page).to have_content("Publicações")

      3.times do |i|
        expect(page).to have_content("Publicação #{9 - i}")
        expect(page).to have_content("Esse é o conteúdo incrível da minha publicação #{9 - i}")
      end

      6.times do |i|
        expect(page).to_not have_content("Publicação #{6 - i}")
        expect(page).to_not have_content("Esse é o conteúdo incrível da minha publicação #{6 - i}")
      end

      expect(page).to have_ordered_text("Publicação 9", "Publicação 8", "Publicação 7")
      within "nav" do
        expect(page).to_not have_link("<")
        expect(page).to have_content("<")
        expect(page).to_not have_link("1")
        expect(page).to have_content("1")
        expect(page).to have_link("2")
        expect(page).to have_link("3")
        expect(page).to_not have_link("4")
        expect(page).to have_link(">")
      end
    end
  end

  context 'and clicks on page 2 of the pagination links' do
    it "renders second page successfully" do
      post_author1 = User.create!(
        name: "MariaTeste", email: "mariateste@email.com", password: 123456
      )
      post_author2 = User.create!(
        name: "JoaoTeste", email: "joaoteste@email.com", password: 123456
      )

      5.times do |i|
        post_author1.posts.create!(
          title: "Publicação #{i + 1}", content: "Esse é o conteúdo incrível da minha publicação #{i + 1}"
        )
      end

      4.times do |i|
        post_author2.posts.create!(
          title: "Publicação #{i + 6}", content: "Esse é o conteúdo incrível da minha publicação #{i + 6}"
        )
      end

      visit root_path
      click_link '2'

      expect(page).to have_content("Publicações")

      3.times do |i|
        expect(page).to have_content("Publicação #{6 - i}")
        expect(page).to have_content("Esse é o conteúdo incrível da minha publicação #{6 - i}")
      end

      3.times do |i|
        expect(page).to_not have_content("Publicação #{3 - i}")
        expect(page).to_not have_content("Esse é o conteúdo incrível da minha publicação #{3 - i}")
        end

      3.times do |i|
        expect(page).to_not have_content("Publicação #{9 - i}")
        expect(page).to_not have_content("Esse é o conteúdo incrível da minha publicação #{9 - i}")
      end

      expect(page).to have_ordered_text("Publicação 6", "Publicação 5", "Publicação 4")
      within "nav" do
        expect(page).to have_link("<")
        expect(page).to have_link("1")
        expect(page).to_not have_link("2")
        expect(page).to have_content("2")
        expect(page).to have_link("3")
        expect(page).to have_link(">")
      end
    end
  end

  context 'and clicks on page 3 of the pagination links' do
    it "renders third page successfully" do
      post_author1 = User.create!(
        name: "MariaTeste", email: "mariateste@email.com", password: 123456
      )
      post_author2 = User.create!(
        name: "JoaoTeste", email: "joaoteste@email.com", password: 123456
      )

      5.times do |i|
        post_author1.posts.create!(
          title: "Publicação #{i + 1}", content: "Esse é o conteúdo incrível da minha publicação #{i + 1}"
        )
      end

      4.times do |i|
        post_author2.posts.create!(
          title: "Publicação #{i + 6}", content: "Esse é o conteúdo incrível da minha publicação #{i + 6}"
        )
      end

      visit root_path
      click_link '3'

      expect(page).to have_content("Publicações")

      3.times do |i|
        expect(page).to have_content("Publicação #{3 - i}")
        expect(page).to have_content("Esse é o conteúdo incrível da minha publicação #{3 - i}")
      end

      3.times do |i|
        expect(page).to_not have_content("Publicação #{6 - i}")
        expect(page).to_not have_content("Esse é o conteúdo incrível da minha publicação #{6 - i}")
        end

      3.times do |i|
        expect(page).to_not have_content("Publicação #{9 - i}")
        expect(page).to_not have_content("Esse é o conteúdo incrível da minha publicação #{9 - i}")
      end

      expect(page).to have_ordered_text("Publicação 3", "Publicação 2", "Publicação 1")
      within "nav" do
        expect(page).to have_link("<")
        expect(page).to have_link("1")
        expect(page).to have_link("2")
        expect(page).to_not have_link("3")
        expect(page).to have_content("3")
        expect(page).to_not have_link(">")
        expect(page).to have_content(">")
      end
    end
  end
end