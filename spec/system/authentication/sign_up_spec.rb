require 'rails_helper'

describe 'User access registration page' do
  context 'from home page' do
    it 'and make the registration successfully' do
      visit root_path
      within 'header nav' do
        click_link 'Criar Nova Conta'
      end
      fill_in 'Nome', with: 'João'
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      within 'form' do
        click_button 'Criar Nova Conta'
      end

      user = User.last

      expect(user).to be_present
      expect(user.name).to eq 'João'
      expect(user.email).to eq 'joao@email.com'
      expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
      within 'header nav' do
        expect(page).to_not have_link 'Criar Nova Conta'
        expect(page).to_not have_link 'Entrar'
        expect(page).to have_button 'Sair'
      end
    end
  end

  it 'and fails to make the registration with invalid fields' do
    visit new_user_registration_path
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    within 'form' do
      click_button 'Criar Nova Conta'
    end

    expect(page).to have_content 'Não foi possível salvar usuário: 3 erros.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end

  it 'and password must be 6 minimum characters' do
    visit new_user_registration_path
    fill_in 'Nome', with: 'João'
    fill_in 'E-mail', with: 'joao@email.com'
    fill_in 'Senha', with: '123'
    fill_in 'Confirme sua senha', with: '123'
    within 'form' do
      click_button 'Criar Nova Conta'
    end

    expect(page).to have_content 'Não foi possível salvar usuário: 1 erro'
    expect(page).to have_content 'Senha é muito curto (mínimo: 6 caracteres)'
  end
end
