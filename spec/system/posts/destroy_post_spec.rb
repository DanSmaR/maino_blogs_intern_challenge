require 'rails_helper'

describe 'User removes post' do
  context 'when logged in' do
    it 'successfully' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)
      post = user.posts.create!(title: 'Título da Publicação', content: 'Conteúdo da Publicação')

      login_as user
      visit post_path(post)
      click_button 'Remover'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content 'Publicação removida com sucesso!'
      expect(Post.count).to eq 0
    end
  end

  context 'When not logged in' do
    it 'cannot see the remove button' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)
      post = user.posts.create!(title: 'Título da Publicação', content: 'Conteúdo da Publicação')

      visit post_path(post)

      expect(page).to_not have_button 'Remover'
    end
  end

  context 'When logged in as other user' do
    it 'cannot see the remove button' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)
      post = user.posts.create!(title: 'Título da Publicação', content: 'Conteúdo da Publicação')
      other_user = User.create!(name: 'João', email: 'joao@email.com', password: 123456)

      login_as other_user
      visit post_path(post)

      expect(page).to_not have_button 'Remover'
    end
  end
end