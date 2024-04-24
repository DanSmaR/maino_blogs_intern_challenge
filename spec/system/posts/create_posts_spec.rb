require 'rails_helper'

describe 'User create post' do
  context 'when logged in' do
    it 'successfully' do
      puts Rails.env
      puts ActiveRecord::Base.connection
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)

      login_as user
      visit root_path
      within 'header nav' do
        click_link 'Criar Publicação'
      end

      expect(page).to have_current_path(new_post_path)

      title = 'Minha Primeira Publicação'
      content = 'Esse é o conteúdo incrível da minha primeira publicação'

      fill_in 'Título', with: title
      fill_in 'Conteúdo', with: content
      fill_in 'Tags', with: 'ruby, rails'
      click_button 'Criar'

      posts = Post.all
      expect(posts.count).to eq 1
      expect(page).to have_current_path(post_path(posts.last))
      expect(page).to have_content('Publicação criada com sucesso!')
      expect(page).to have_content('Publicado por Maria')
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content('Tags:')
      expect(page).to have_link('#ruby')
      expect(page).to have_link('#rails')
    end

    it 'only with required fields' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)

      login_as user
      visit new_post_path

      fill_in 'Título', with: ''
      fill_in 'Conteúdo', with: ''
      fill_in 'Tags', with: ''
      click_button 'Criar'

      expect(Post.count).to eq 0
      expect(page).to have_content 'Não foi possível criar sua publicação'
      expect(page).to have_content 'Título não pode ficar em branco'
      expect(page).to have_content 'Conteúdo não pode ficar em branco'
    end
  end

  context 'when NOT logged in' do
    it 'cannot access page' do
      visit new_post_path

      expect(page).to have_current_path new_user_session_path
    end
  end
end
