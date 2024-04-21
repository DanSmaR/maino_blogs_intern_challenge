require 'rails_helper'

describe 'User update his profile' do
  context 'when logged in' do
    it 'successfully' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)

      login_as user
      visit root_path

      within 'header nav' do
        click_link 'Editar Maria'
      end

      fill_in I18n.translate('activerecord.attributes.user.name'), with: 'Mariana'
      fill_in 'E-mail', with: 'mariana@email.com'
      fill_in 'Senha', with: '111111'
      fill_in 'Confirme sua senha', with: '111111'
      fill_in 'Senha atual', with: '123456'
      click_button 'Atualizar'

      updated_user = User.last

      expect(page).to have_current_path root_path
      expect(page).to have_content 'A sua conta foi atualizada com sucesso.'
      expect(updated_user.name).to eq 'Mariana'
      expect(updated_user.email).to eq 'mariana@email.com'
      within 'header nav' do
        expect(page).to have_link 'Editar Mariana'
      end
    end

    it 'and it shows errors for required fields' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 123456)

      login_as user
      visit root_path

      within 'header nav' do
        click_link 'Editar Maria'
      end

      fill_in I18n.translate('activerecord.attributes.user.name'), with: ''
      fill_in 'E-mail', with: ''
      fill_in 'Senha', with: ''
      fill_in 'Confirme sua senha', with: ''
      fill_in 'Senha atual', with: ''
      click_button 'Atualizar'

      updated_user = User.last

      expect(page).to have_content 'Não foi possível salvar usuário: 3 erros.'
      expect(page).to have_content 'E-mail não pode ficar em branco'
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Senha atual não pode ficar em branco'
      expect(updated_user.name).to eq 'Maria'
      expect(updated_user.email).to eq 'maria@email.com'
      within 'header nav' do
        expect(page).to have_link 'Editar Maria'
      end
    end
  end

  context 'when logged out' do
    it 'Edit link dos not appear' do
      visit root_path

      within 'header nav' do
        expect(page).to_not have_link 'Editar Mariana'
      end
    end
  end
end