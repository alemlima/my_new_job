require 'rails_helper'

describe 'Candidate decline job proposal' do
  scenario ' successfully' do
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
    job_application = job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')
    
    job_proposal = job_application.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR',headhunter_id: headhunter.id)

    visit root_path
    
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    click_on 'Minhas propostas'
    click_on 'Estágio Dev'
    click_on 'Recusar proposta'

    fill_in 'Feedback', with: 'Caro recrutador, agradeço a proposta mas ela não atende minhas espectativas. Muito obrigado.'
    click_on 'Enviar'

    expect(page).to have_content('Proposta rejeitada com sucesso!')
    expect(page).to have_content('Você ainda não possui nenhuma proposta!')
    expect(page).to have_link('Voltar')  

  end

  scenario 'and do not provide a feedback' do
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
    job_application = job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')
    
    job_proposal = job_application.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR',headhunter_id: headhunter.id)

    visit root_path
    
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    click_on 'Minhas propostas'
    click_on 'Estágio Dev'
    click_on 'Recusar proposta'

    click_on 'Enviar'
    
    expect(page).to have_content('Proposta rejeitada com sucesso!')
    expect(page).to have_content('Você ainda não possui nenhuma proposta!')
    expect(page).to have_link('Voltar')

  end
  
  scenario 'and can go back whithout declining' do
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
    job_application = job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')
    
    job_proposal = job_application.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR',headhunter_id: headhunter.id)

    visit root_path
    
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    click_on 'Minhas propostas'
    click_on 'Estágio Dev'
    click_on 'Recusar proposta'
    click_on 'Voltar'

    expect(current_path).to eq job_proposal_path(job_proposal.id)
  end
end