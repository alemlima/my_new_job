require 'rails_helper'

describe 'Headhunter decline job application' do

  scenario ' and must fill in feedback' do
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
    click_on 'Ver candidatura de Alexandre Moreira Lima'
    click_on 'Rejeitar candidatura'
    
    click_on 'Enviar'
      
    expect(page).to have_content('Feedback não pode ficar em branco')
    expect(page).to have_link('Voltar')

  end

  scenario ' successfuly' do
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
    click_on 'Ver candidatura de Alexandre Moreira Lima'
    click_on 'Rejeitar candidatura'
    fill_in 'Feedback', with: 'Infelizmente seu perfil não se adequa aos requisitos exigidos para esta vaga. Agradeçemos o interesse e boa sorte em sua busca!'
    click_on 'Enviar'

    expect(page).to have_content('Candidatura rejeitada com sucesso')
    expect(page).to have_content('Feedback: Infelizmente seu perfil não se adequa aos requisitos exigidos para esta vaga. Agradeçemos o interesse e boa sorte em sua busca!')
    expect(page).to have_link('Voltar')

  end

  scenario ' and does not see Rejeitar candidatura link' do
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
    click_on 'Ver candidatura de Alexandre Moreira Lima'
    click_on 'Rejeitar candidatura'
    fill_in 'Feedback', with: 'Infelizmente seu perfil não se adequa aos requisitos exigidos para esta vaga. Agradeçemos o interesse e boa sorte em sua busca!'
    click_on 'Enviar'

    expect(page).not_to have_link('Rejeitar candidatura')
    expect(page).to have_content('Candidatura rejeitada com sucesso')
    expect(page).to have_content('Feedback: Infelizmente seu perfil não se adequa aos requisitos exigidos para esta vaga. Agradeçemos o interesse e boa sorte em sua busca!')
    expect(page).to have_link('Voltar')

  end

  scenario ' and return to job applications list' do
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
    click_on 'Ver candidatura de Alexandre Moreira Lima'
    click_on 'Rejeitar candidatura'
    fill_in 'Feedback', with: 'Infelizmente seu perfil não se adequa aos requisitos exigidos para esta vaga. Agradeçemos o interesse e boa sorte em sua busca!'
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq job_path(job.id)
    
  end
end