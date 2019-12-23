require 'rails_helper'

feature 'candidate creates an account' do
  scenario 'sucessfully' do
  
    visit root_path
    click_on 'Quero uma vaga'

    fill_in 'Email', with: 'ale@ale.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Criar conta'

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    expect(page).to have_content("Olá ale@ale.com")
    expect(page).to have_link('Sair')
    
  end

  scenario 'and does not see Quero uma vaga link' do

    visit root_path
    click_on 'Quero uma vaga'

    fill_in 'Email', with: 'ale@ale.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Criar conta'

    
    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    expect(page).to have_content("Olá ale@ale.com")
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Quero uma vaga')

  end
end