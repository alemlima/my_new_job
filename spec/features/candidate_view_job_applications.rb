require 'rails_helper'

describe 'Candidate view job application' do
  scenario ' must be logged' do
    
    visit job_applications_path
    

    expect(current_path).to eq root_path
    expect(page).to have_content('Você deve estar logado para acessar este recurso')

  end

  scenario ' but does not have any job applications' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,
                                      candidate_id: candidate.id)
  profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

  visit root_path
  click_on 'Acessar como Candidato'

  fill_in 'Email', with: candidate.email
  fill_in 'Senha', with: candidate.password

  click_on 'Login'
  click_on 'Minhas candidaturas'

  expect(page).to have_content('Vocẽ não tem candidaturas ativas!')

  end

  scenario ' successfully' do

    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    other_candidate = Candidate.create!(email: 'ze@ze.com', password:'987654')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,
                                      candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    other_profile = CandidateProfile.create!(name: 'Jose Carlos', academic_background: 'Bacharel em Sistemas de Informação', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 35.years.ago, candidate_id: other_candidate.id)
    other_profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
      
    job = Job.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                      desired_skills: 'Fazer crud e buscar café sem derramar', 
                      skill_level: 'Estagiário', contract_type: 'Estágio', 
                      salary: 1500, localization: 'Paulista', 
                      limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...') 

    other_job = Job.create!(title: 'Estágio Web', description: 'HTML, CSS, JS e buscar café', 
                            desired_skills: 'Desenvolvimento web e buscar café sem derramar', 
                            skill_level: 'Estagiário', contract_type: 'Estágio', 
                            salary: 2500, localization: 'Vila Mariana', 
                            limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    other_job.job_application.create!(candidate_id: other_candidate.id, cover_letter: '1 ano de experiência desenvolvendo web apps...') 

    visit root_path
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Login'
    click_on 'Minhas candidaturas'

    expect(page).to have_content('Estágio Dev')
    expect(page).to have_content('CRUD e buscar café')
    expect(page).to have_link('Voltar')

  end

  scenario ' and only see his applications' do

    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    other_candidate = Candidate.create!(email: 'ze@ze.com', password:'987654')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,
                                      candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    other_profile = CandidateProfile.create!(name: 'Jose Carlos', academic_background: 'Bacharel em Sistemas de Informação', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 35.years.ago, candidate_id: other_candidate.id)
    other_profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
      
    job = Job.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                      desired_skills: 'Fazer crud e buscar café sem derramar', 
                      skill_level: 'Estagiário', contract_type: 'Estágio', 
                      salary: 1500, localization: 'Paulista', 
                      limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...') 

    other_job = Job.create!(title: 'Estágio Web', description: 'HTML, CSS, JS e buscar café', 
                            desired_skills: 'Desenvolvimento web e buscar café sem derramar', 
                            skill_level: 'Estagiário', contract_type: 'Estágio', 
                            salary: 2500, localization: 'Vila Mariana', 
                            limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    other_job.job_application.create!(candidate_id: other_candidate.id, cover_letter: '1 ano de experiência desenvolvendo web apps...') 

    visit root_path
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Login'
    click_on 'Minhas candidaturas'

    expect(page).not_to have_content('Estágio Web')
    expect(page).not_to have_content('HTML, CSS, JS e buscar café')
    expect(page).to have_link('Voltar')

  end
end