require 'rails_helper'

describe 'Candidate can view his job proposals' do
  scenario 'but do not have any proposals' do
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
    
    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    click_on 'Minhas propostas'

    expect(page).to have_css('h1', text:'Minhas propostas:')
    expect(page).to have_content('Você ainda não possui nenhuma proposta!')
    expect(page).to have_link('Voltar')
  
  end

  scenario 'and view job proposal list' do
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

    other_job = headhunter.jobs.create!(title: 'Estágio Web', description: 'HTML, CSS, JS', 
                                        desired_skills: 'Fazer correções em sites', 
                                        skill_level: 'Estagiário', contract_type: 'Estágio', 
                                        salary: 1400, localization: 'Vila Mariana', 
                                        limit_date: 5.days.from_now)
    other_job_application = other_job.job_application.create!(candidate_id: candidate.id, cover_letter: '4 meses de experiência desenvolvendo web apps...')
    
    job_application.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR')

    other_job_application.create_job_proposal(start_date: 8.days.from_now, salary: 1400, benefits:'Vale transporte, VR, Convênio médico',
                                        job_roles:'Será responsável por pequenas correções em sites',
                                        job_expectations:'Capaz de realizar pequenas correções em sites utilizando HTML,CSS e JS',
                                        additional_infos:'VR: R$15, Convênio médico: Porto Seguro')
    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    click_on 'Minhas propostas'

    expect(page).to have_css('h3', text: 'Estágio Dev' )
    expect(page).to have_css('h3', text: 'Estágio Web' )
    expect(page).to have_link('Voltar')
  end

  scenario 'and view job proposal' do
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

    other_job = headhunter.jobs.create!(title: 'Estágio Web', description: 'HTML, CSS, JS', 
                                        desired_skills: 'Fazer correções em sites', 
                                        skill_level: 'Estagiário', contract_type: 'Estágio', 
                                        salary: 1400, localization: 'Vila Mariana', 
                                        limit_date: 5.days.from_now)
    other_job_application = other_job.job_application.create!(candidate_id: candidate.id, cover_letter: '4 meses de experiência desenvolvendo web apps...')
    
    job_proposal = job_application.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR')

    other_job_application.create_job_proposal(start_date: 8.days.from_now, salary: 1400, benefits:'Vale transporte, VR, Convênio médico',
                                        job_roles:'Será responsável por pequenas correções em sites',
                                        job_expectations:'Capaz de realizar pequenas correções em sites utilizando HTML,CSS e JS',
                                        additional_infos:'VR: R$15, Convênio médico: Porto Seguro')
    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    click_on 'Minhas propostas'
    click_on 'Estágio Dev'

    expect(page).to have_content("Vaga: #{job.title}")
    expect(page).to have_content("Descrição da vaga: #{job.description}" )
    expect(page).to have_content("Data de início: #{job_proposal.start_date.strftime('%d/%m/%Y')}")
    expect(page).to have_content("Benefícios: #{job_proposal.benefits}")
    expect(page).to have_content("Atribuições da vaga: #{job_proposal.job_roles}")
    expect(page).to have_content("Expectativas da empresa: #{job_proposal.job_expectations}")
    expect(page).to have_content("Informações adicionais: #{job_proposal.additional_infos}")
    expect(page).to have_link('Voltar')
  end    

  scenario 'and return to job proposal list' do
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

    other_job = headhunter.jobs.create!(title: 'Estágio Web', description: 'HTML, CSS, JS', 
                                        desired_skills: 'Fazer correções em sites', 
                                        skill_level: 'Estagiário', contract_type: 'Estágio', 
                                        salary: 1400, localization: 'Vila Mariana', 
                                        limit_date: 5.days.from_now)
    other_job_application = other_job.job_application.create!(candidate_id: candidate.id, cover_letter: '4 meses de experiência desenvolvendo web apps...')
    
    job_proposal = job_application.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR')

    other_job_application.create_job_proposal(start_date: 8.days.from_now, salary: 1400, benefits:'Vale transporte, VR, Convênio médico',
                                        job_roles:'Será responsável por pequenas correções em sites',
                                        job_expectations:'Capaz de realizar pequenas correções em sites utilizando HTML,CSS e JS',
                                        additional_infos:'VR: R$15, Convênio médico: Porto Seguro')
    visit root_path

    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password
    click_on 'Login'

    click_on 'Minhas propostas'
    click_on 'Estágio Dev'

    click_on 'Voltar'

    expect(current_path).to eq job_proposals_path
    
  end
end