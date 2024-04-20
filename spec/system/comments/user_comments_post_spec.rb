require 'rails_helper'

describe 'User comments in any post' do
  context 'when logged in' do
    it 'successfully' do
      publisher = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)
      post = publisher.posts.create!(title: 'Título da Publicação', content: 'Conteúdo da Publicação')
      commenter = User.create!(name: 'Joao', email: 'joao@email.com', password: 123456)
      comment_message = 'Achei seu post muito interessante'

      login_as commenter
      visit post_path post

      fill_in 'Mensagem', with: comment_message
      click_button 'Comentar'

      expect(page).to have_current_path post_path(post)
      expect(page).to have_content 'Comentário enviado com sucesso'
      expect(page).to have_content '1 Comentário'
      expect(page).to have_content 'Joao'
      expect(page).to have_content comment_message
    end
  end

  context 'Anonymously when not logged in' do
    it 'successfully' do
      publisher = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)
      post = publisher.posts.create!(title: 'Título da Publicação', content: 'Conteúdo da Publicação')
      comment_message = 'Achei seu post muito interessante'

      visit post_path post

      fill_in 'Mensagem', with: comment_message
      click_button 'Comentar'

      expect(page).to have_current_path post_path(post)
      expect(page).to have_content 'Comentário enviado com sucesso'
      expect(page).to have_content '1 Comentário'
      expect(page).to have_content 'Anônimo'
      expect(page).to have_content comment_message
    end
  end
end