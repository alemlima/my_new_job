require 'rails_helper'

describe 'Headhunter view job application' do
  scenario ' but must be logged in' do
   
    visit jobs_path

    expect(current_path).to eq root_path
    expect(page).to have_content('Você deve estar logado para acessar este recurso')

  end

  scenario ' and have no applications yet' do
  
    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
    headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                            desired_skills: 'Fazer crud e buscar café sem derramar', 
                            skill_level: 'Estagiário', contract_type: 'Estágio', 
                            salary: 1500, localization: 'Paulista', 
                            limit_date: 5.days.from_now)

    visit root_path
      
    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Vagas'
    click_on 'Estágio Dev'

    expect(page).to have_content('Ainda não há candidaturas para esta vaga.')
  end

  scenario ' successfully' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    other_candidate = Candidate.create!(email: 'ze@ze.com', password:'987654')

    other_profile = CandidateProfile.create!(name: 'Jose Carlos', academic_background: 'Bacharel em Sistemas de Informação', 
                                            description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                            social_network: 'linkedin', birth_date: 35.years.ago, candidate_id: other_candidate.id)
    other_profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")


    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')

    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                  desired_skills: 'Fazer crud e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Paulista', 
                                  limit_date: 5.days.from_now)
    job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')

    job.job_application.create!(candidate_id: other_candidate.id, cover_letter: '1 ano de experiência desenvolvendo web apps...')  

    visit root_path
      
    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Vagas'
    click_on 'Estágio Dev'

    expect(page).to have_link('Ver perfil de Alexandre Moreira Lima')
    expect(page).to have_link('Ver perfil de Jose Carlos')

  end

  scenario ' and can see candidate profile' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    other_candidate = Candidate.create!(email: 'ze@ze.com', password:'987654')

    other_profile = CandidateProfile.create!(name: 'Jose Carlos', academic_background: 'Bacharel em Sistemas de Informação', 
                                            description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                            social_network: 'linkedin', birth_date: 35.years.ago, candidate_id: other_candidate.id)
    other_profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')

    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                  desired_skills: 'Fazer crud e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Paulista', 
                                  limit_date: 5.days.from_now)
    job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')

    visit root_path
      
    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Vagas'
    click_on 'Estágio Dev'
    click_on 'Ver perfil de Alexandre Moreira Lima'  

    expect(page).to have_css('h3', text: 'Alexandre Moreira Lima')
    expect(page).to have_css("img[src*='foto.jpg']")
    expect(page).to have_content('Formação: Tecnólogo em ADS')
    expect(page).to have_content('Sobre você: Profissional...')
    expect(page).to have_content('Experiência profissional: Profissional com experiencia...')
    expect(page).to have_content('Linkedin: linkedin')
    expect(page).to have_content("Data de nascimento: #{34.years.ago.strftime('%d/%m/%Y')}")
    
  end

  scenario ' and return to jobs list from candidate profile' do
  
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
    job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')

    visit root_path
      
    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Vagas'
    click_on 'Estágio Dev'
    click_on 'Ver perfil de Alexandre Moreira Lima'  
    click_on 'Voltar'
    
    expect(current_path).to eq job_path(job.id)

  end

  scenario ' and can see job application' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    other_candidate = Candidate.create!(email: 'ze@ze.com', password:'987654')

    other_profile = CandidateProfile.create!(name: 'Jose Carlos', academic_background: 'Bacharel em Sistemas de Informação', 
                                            description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                            social_network: 'linkedin', birth_date: 35.years.ago, candidate_id: other_candidate.id)
    other_profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')

    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                  desired_skills: 'Fazer crud e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Paulista', 
                                  limit_date: 5.days.from_now)
    job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')

    visit root_path
      
    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Vagas'
    click_on 'Estágio Dev'
    click_on 'Ver candidatura de Alexandre Moreira Lima'

    expect(page).to have_css('h3', text: 'Candidatura de:')
    expect(page).to have_content('Alexandre Moreira Lima')
    expect(page).to have_content('Estágio Dev')
    expect(page).to have_content('CRUD e buscar café')
    expect(page).to have_content('6 meses de experiência desenvolvendo web apps...')
    expect(page).to have_link('Voltar')
  
  end

  scenario ' and return to jobs list from candidate job application' do

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
    job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')

    visit root_path
      
    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Vagas'
    click_on 'Estágio Dev'
    click_on 'Ver candidatura de Alexandre Moreira Lima'
    click_on 'Voltar'

    expect(current_path).to eq job_path(job.id)
  end

end