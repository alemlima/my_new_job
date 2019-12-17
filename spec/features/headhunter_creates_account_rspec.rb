require 'rails_helper'

feature 'headhunter creates an account' do
  scenario 'successfully' do
  
    visit root_path
    click_on 'Tenho uma vaga'

    fill_in 'Email', with: 'ale@ale.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmação de Senha', with: '12345678'
    click_on 'Criar conta'

    expect(current_path).to eq root_path
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content("Olá ale@ale.com")
    expect(page).to have_link('Sair')
    
  end

  scenario 'and does not see Tenho uma vaga link' do

    visit root_path
    click_on 'Tenho uma vaga'

    fill_in 'Email', with: 'ale@ale.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmação de Senha', with: '12345678'
    click_on 'Criar conta'

    expect(current_path).to eq root_path
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content("Olá ale@ale.com")
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Tenho uma vaga')

  end
end