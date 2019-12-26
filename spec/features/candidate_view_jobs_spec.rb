require 'rails_helper'

describe 'Candidate view jobs list' do
  scenario ' and must be logged in' do
    
    visit jobs_path
    

    expect(current_path).to eq root_path

  end

  scenario ' successfully' do
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    Job.create!(title: 'Estágio FullStack', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)            

    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!

    login_as(candidate, scope: :candidate)

  visit root_path
  click_on 'Vagas'
  
    expect(page).to have_content('Estágio Rails')
    expect(page).to have_content('Estágio FullStack')
    expect(page).to have_link('Voltar')  

  end

  scenario ' and return to home page' do
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    Job.create!(title: 'Estágio FullStack', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)            

    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!

    login_as(candidate, scope: :candidate)

  visit root_path
  click_on 'Vagas'
  click_on 'Voltar'
  
    expect(current_path).to eq root_path
  
  end
end