require 'rails_helper'

describe 'Candidate view job application feedback' do

  scenario 'and see a message on job application list from the ones that had been declined' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
        
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')

    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                  desired_skills: 'Fazer crud e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Paulista', 
                                  limit_date: 5.days.from_now)
    other_job = headhunter.jobs.create!(title: 'Estágio Rails', description: 'CRUD e TDD', 
                                  desired_skills: 'Fazer crud com TDD e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Vila Mariana', 
                                  limit_date: 5.days.from_now)

    job_application = job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...',feedback:'Infelizmente você não atende os requisitos solicitados.')
    job_application.declined!

    other_job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')
    
    visit root_path
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    click_on 'Minhas candidaturas'

    expect(page).to have_link('Estágio Dev')
    expect(page).to have_link('Estágio Rails')
    expect(page).to have_css('p', text: 'Candidatura recusada, acesse a candidatura para ver o feedback', count: 1)

  end

  scenario 'and see the feedback from headhunter in the job application' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
        
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')

    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                  desired_skills: 'Fazer crud e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Paulista', 
                                  limit_date: 5.days.from_now)
    other_job = headhunter.jobs.create!(title: 'Estágio Rails', description: 'CRUD e TDD', 
                                  desired_skills: 'Fazer crud com TDD e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Vila Mariana', 
                                  limit_date: 5.days.from_now)

    job_application = job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...',feedback:'Infelizmente você não atende os requisitos solicitados.')
    job_application.declined!

    other_job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')
    
    visit root_path
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    click_on 'Minhas candidaturas'
    click_on 'Estágio Dev'

    expect(page).to have_content('Feedback: Infelizmente você não atende os requisitos solicitados.')
    
  end

end