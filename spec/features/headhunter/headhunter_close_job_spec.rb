require 'rails_helper'

describe 'Headhunter can close a job position' do
  scenario 'successfully', js: true do
    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
    
    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
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
    accept_confirm  do
      click_link 'Encerrar vaga' 
    end

    job.reload
    
    expect(job.status).eql?('closed')
    expect(page).to have_content('Vaga encerrada com sucesso!')
    expect(page).to have_link('Voltar')

  end

  scenario 'and automatically decline all the applications for that job', js: true do
    
      headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
      
      job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                    desired_skills: 'Fazer crud e buscar café sem derramar', 
                                    skill_level: 'Estagiário', contract_type: 'Estágio', 
                                    salary: 1500, localization: 'Paulista', 
                                    limit_date: 5.days.from_now)
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

      application = job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')
      other_application = job.job_application.create!(candidate_id: other_candidate.id, cover_letter: '1 ano de experiência desenvolvendo web apps...')

    visit root_path
      
    click_on 'Acessar como Headhunter'
  
    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'
  
    click_on 'Vagas'
    click_on 'Estágio Dev'
    accept_confirm  do
      click_link 'Encerrar vaga' 
    end

    job.reload

    expect(job.status).eql?('closed')
    expect(page).to have_content('Vaga encerrada com sucesso!')
    expect(page).to have_link('Voltar')
    expect(application.status).eql?('declined')
    expect(application.feedback).eql?('Infelizmente a vaga foi encerrada pelo recrutador')
    expect(other_application.status).eql?('declined')
    expect(other_application.feedback).eql?('Infelizmente a vaga foi encerrada pelo recrutador')
   
  end

  scenario 'and does not see Encerrar vaga link when job is closed' do
    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
    
    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                  desired_skills: 'Fazer crud e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Paulista', 
                                  limit_date: 5.days.from_now, status: 'closed')

    visit root_path
      
    click_on 'Acessar como Headhunter'
  
    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'
  
    click_on 'Vagas'
    click_on 'Estágio Dev'
       
    
    expect(page).not_to have_link('Encerrar vaga')
    expect(page).to have_link('Voltar')

  end
end
