require 'rails_helper'

describe 'User edits post' do
  context 'when logged in' do
    it 'successfully' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)
      post = user.posts.create!(title: 'Título da Publicação', content: 'Conteúdo da Publicação')

      login_as user
      visit post_path(post)
      click_link 'Editar'

      expect(page).to have_current_path(edit_post_path(post))

      title = 'Minha Primeira Publicação'
      content = 'Esse é o conteúdo incrível da minha primeira publicação'

      fill_in 'Título', with: title
      fill_in 'Conteúdo', with: content
      click_button 'Salvar'

      posts = Post.all
      expect(posts.count).to eq 1
      expect(page).to have_current_path(post_path(posts.last))
      expect(page).to have_content('Publicação editada com sucesso!')
      expect(page).to have_content(title)
      expect(page).to have_content(content)
    end

    it 'only with required fields' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)
      post = user.posts.create!(title: 'Título da Publicação', content: 'Conteúdo da Publicação')

      login_as user
      visit post_path(post)
      click_link 'Editar'

      expect(page).to have_current_path(edit_post_path(post))

      fill_in 'Título', with: ''
      fill_in 'Conteúdo', with: ''
      click_button 'Salvar'

      expect(Post.count).to eq 1
      expect(page).to have_content 'Não foi possível editar sua publicação'
      expect(page).to have_content 'Título não pode ficar em branco'
      expect(page).to have_content 'Conteúdo não pode ficar em branco'
    end
  end

  context 'when NOT logged in' do
    it 'cannot access page' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)
      post = user.posts.create!(title: 'Título da Publicação', content: 'Conteúdo da Publicação')

      visit edit_post_path(post)

      expect(page).to have_current_path new_user_session_path
    end
  end
end
