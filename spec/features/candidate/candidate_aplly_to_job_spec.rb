require 'rails_helper'

describe 'Candidate aplly to job' do
  scenario ' successfully' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,
                                      candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
      
    Job.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    visit root_path
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Login'

    click_on 'Vagas'
    click_on 'Estágio Dev'
    click_on 'Candidatar-se'

    fill_in 'Carta de apresentação', with: '6 meses de experiência desenvolvendo web apps...'

    click_on 'Enviar'
    
    expect(page).to have_content('Candidatura aplicada com sucesso')
    expect(page).to have_content('Estágio Dev')
    expect(page).to have_content('CRUD e buscar café')
    expect(page).to have_content('6 meses de experiência desenvolvendo web apps...')
    expect(page).to have_link('Voltar')

  end

  scenario ' and must fill in cover letter' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,
                                      candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
      
    Job.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
   
    visit root_path
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Login'

    click_on 'Vagas'
    click_on 'Estágio Dev'
    click_on 'Candidatar-se'

    click_on 'Enviar'

    expect(page).to have_content('Carta de apresentação não pode ficar em branco') 

  end

  scenario ' and return to jobs list' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,
                                      candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
      
    Job.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
   
    visit root_path
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Login'

    click_on 'Vagas'
    click_on 'Estágio Dev'
    click_on 'Candidatar-se'

    fill_in 'Carta de apresentação', with: '6 meses de experiência desenvolvendo web apps...'

    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq jobs_path
    
  end
end