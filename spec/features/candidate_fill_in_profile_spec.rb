require 'rails_helper'

feature 'candidate fill in profile' do
  scenario 'successfully' do
    
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    login_as(candidate, scope: :candidate)

    visit new_candidate_profile_path
    
    
    fill_in 'Nome', with: 'Alexandre Moreira Lima'
    fill_in 'Formação', with: 'Tecnólogo em Análise e Desenvolvimento de Sistemas - Uninove'
    fill_in 'Sobre você', with: 'Profissional com experiência em ....'
    fill_in 'Experiência profissional', with: '4/2017 - Atual - Desenvolvedor Rails - Rebase - 
                                               atuando com desenvolvimento Rails ....'
    fill_in 'Foto', with: 'foto.jpg'
    fill_in 'Linkedin', with: 'linkedin.com/alexandrelima'
    fill_in 'Data de nascimento', with: 34.years.ago
    find("#candidate_profile_candidate_id", visible: false).set("#{candidate.id}")

    click_on 'Enviar'

    expect(page).to have_content('Perfil cadastrado com sucesso')

    expect(page).to have_css('h3', text: 'Alexandre Moreira Lima')

    expect(page).to have_link('Voltar')

  end

  scenario 'and return to home page' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    login_as(candidate, scope: :candidate)

    visit new_candidate_profile_path
    
    
    fill_in 'Nome', with: 'Alexandre Moreira Lima'
    fill_in 'Formação', with: 'Tecnólogo em Análise e Desenvolvimento de Sistemas - Uninove'
    fill_in 'Sobre você', with: 'Profissional com experiência em ....'
    fill_in 'Experiência profissional', with: '4/2017 - Atual - Desenvolvedor Rails - Rebase - 
                                               atuando com desenvolvimento Rails ....'
    fill_in 'Foto', with: 'foto.jpg'
    fill_in 'Linkedin', with: 'linkedin.com/alexandrelima'
    fill_in 'Data de nascimento', with: 34.years.ago
    find("#candidate_profile_candidate_id", visible: false).set("#{candidate.id}")

    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario ' and must be logged in' do
  
    visit new_candidate_profile_path

    expect(current_path).to eq new_candidate_session_path
  end
end