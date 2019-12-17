require 'rails_helper'

feature 'candidate sign in' do
    
  scenario 'successfully ' do
    candidate = Candidate.create!(email: 'ale@ale.com', password: '12345678')

    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Entrar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content("Olá #{candidate.email}")
    expect(page).to have_link('Sair')

  end

  scenario ' and does not see Acessar como Candidato when logged in' do
    
    candidate = Candidate.create!(email: 'ale@ale.com', password: '12345678')

    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Entrar'

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Acessar como Candidato')

  end

  scenario ' and sign_out sucessfully ' do

    candidate = Candidate.create!(email: 'ale@ale.com', password: '12345678')

    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Entrar'
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_link('Acessar como Candidato')
    
  end
end
