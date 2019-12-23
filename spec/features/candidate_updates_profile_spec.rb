require 'rails_helper'

feature 'candidate updates profile' do
  scenario ' and fill in all fields' do
    
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', candidate_id: candidate.id)
    
    visit root_path
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Login'

    
    fill_in 'Formação', with: 'Tecnólogo em Análise e Desenvolvimento de Sistemas - Uninove'
    fill_in 'Sobre você', with: 'Profissional com experiência em ....'
    fill_in 'Experiência profissional', with: '4/2017 - Atual - Desenvolvedor Rails - Rebase - 
                                               atuando com desenvolvimento Rails ....'
    attach_file('Foto','/home/ale/Downloads/foto.jpg')
    fill_in 'Linkedin', with: 'linkedin.com/alexandrelima'
    fill_in 'Data de nascimento', with: 34.years.ago
    

    click_on 'Salvar perfil'

    expect(page).to have_content('Perfil atualizado com sucesso')

    expect(page).to have_css('h3', text: 'Alexandre Moreira Lima')
    expect(page).to have_content('Status do perfil: complete')

    expect(page).to have_link('Voltar')

  end

  scenario ' and does not fill in all fields' do
    
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', candidate_id: candidate.id)
    
    visit root_path
    
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Login'
    
        
    fill_in 'Formação', with: 'Tecnólogo em Análise e Desenvolvimento de Sistemas - Uninove' 

    click_on 'Salvar perfil'

    expect(page).to have_content('Perfil atualizado com sucesso')

    expect(page).to have_css('h3', text: 'Alexandre Moreira Lima')
    expect(page).to have_content('Status do perfil: incomplete')

    expect(page).to have_link('Voltar')

  end

  scenario 'and return to home page' do
    
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', candidate_id: candidate.id)
    
    visit root_path
    
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Login'
    
        
    fill_in 'Formação', with: 'Tecnólogo em Análise e Desenvolvimento de Sistemas - Uninove' 

    click_on 'Salvar perfil'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario ' and must be logged in' do
  
    visit new_candidate_profile_path

    expect(current_path).to eq new_candidate_session_path
  end
end