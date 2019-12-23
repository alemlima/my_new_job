require 'rails_helper'

feature 'candidate sign in' do
    
  scenario 'successfully ' do
    candidate = Candidate.create!(email: 'ale@ale.com', password: '12345678')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', candidate_id: candidate.id)

    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    expect(current_path).to eq edit_candidate_profile_path(candidate)
    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content("Olá #{candidate.email}")
    expect(page).to have_link('Sair')

  end

  scenario ' and does not see Acessar como Candidato when logged in' do
    
    candidate = Candidate.create!(email: 'ale@ale.com', password: '12345678')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', candidate_id: candidate.id)

    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    expect(current_path).to eq edit_candidate_profile_path(candidate)
    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).not_to have_link('Acessar como Candidato')

  end

  scenario ' and sign_out sucessfully ' do

    candidate = Candidate.create!(email: 'ale@ale.com', password: '12345678')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', candidate_id: candidate.id)

    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_content('Logout efetuado com sucesso.')
    expect(page).to have_link('Acessar como Candidato')
    
  end
end
