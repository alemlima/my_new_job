require 'rails_helper'

feature 'headhunter sign in' do
    
  scenario 'from home page' do
    headhunter = Headhunter.create!(email: 'ale@ale.com', password: '12345678')

    visit root_path

    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    expect(current_path).to eq root_path
    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content("Olá #{headhunter.email}")
    expect(page).to have_link('Sair')

  end

  scenario ' and does not see Acessar como Headhunter when logged in' do
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password: '12345678')

    visit root_path

    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    expect(current_path).to eq root_path
    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).not_to have_link('Acessar como Headhunter')

  end

  scenario ' and sign_out sucessfully ' do

    headhunter = Headhunter.create!(email: 'ale@ale.com', password: '12345678')

    visit root_path

    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_content('Logout efetuado com sucesso.')
    expect(page).to have_link('Acessar como Headhunter')
    
  end
end
