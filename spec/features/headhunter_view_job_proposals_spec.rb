require 'rails_helper'

describe 'Headhunter view job proposals' do
  scenario 'and do not have any proposal ' do
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
    
    
    visit root_path

    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Propostas enviadas'

    expect(page).to have_css('p', text: 'Não foram enviadas propostas a candidaturas!')
    
  end
  
  scenario 'and only see his proposals' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
        
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')
    other_headhunter = Headhunter.create!(email: 'joao@globo.com', password:'87654321')

    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                  desired_skills: 'Fazer crud e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Paulista', 
                                  limit_date: 5.days.from_now)
    job_application = job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')

    other_job = other_headhunter.jobs.create!(title: 'Estágio Web', description: 'HTML, CSS, JS', 
                                        desired_skills: 'Fazer correções em sites', 
                                        skill_level: 'Estagiário', contract_type: 'Estágio', 
                                        salary: 1400, localization: 'Vila Mariana', 
                                        limit_date: 5.days.from_now)
    other_job_application = other_job.job_application.create!(candidate_id: candidate.id, cover_letter: '4 meses de experiência desenvolvendo web apps...')
    
    job_proposal = job_application.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR',headhunter_id: headhunter.id)

    other_job_application.create_job_proposal(start_date: 8.days.from_now, salary: 1400, benefits:'Vale transporte, VR, Convênio médico',
                                        job_roles:'Será responsável por pequenas correções em sites',
                                        job_expectations:'Capaz de realizar pequenas correções em sites utilizando HTML,CSS e JS',
                                        additional_infos:'VR: R$15, Convênio médico: Porto Seguro',headhunter_id: other_headhunter.id)
    visit root_path

    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Propostas enviadas'

    expect(page).to have_css('h3', text: "#{candidate.candidate_profile.name}", count: 1)
    expect(page).to have_link('Voltar')

  end

  scenario 'and see all proposals sent by him' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    other_candidate = Candidate.create!(email: 'ze@ze.com', password:'98765432')
        
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    other_profile = CandidateProfile.create!(name: 'José Carlos', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: other_candidate.id)
    other_profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')

    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                  desired_skills: 'Fazer crud e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Paulista', 
                                  limit_date: 5.days.from_now)
    job_application = job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')
    job_application2 = job.job_application.create!(candidate_id: other_candidate.id, cover_letter: '1 ano de experiência desenvolvendo web apps...')  

    
    job_application.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR',headhunter_id: headhunter.id)

    job_application2.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR',headhunter_id: headhunter.id)

    visit root_path

    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Propostas enviadas'

    expect(page).to have_css('h3', text: "#{candidate.candidate_profile.name}")
    expect(page).to have_css('h3', text: "#{other_candidate.candidate_profile.name}")
    expect(page).to have_link('Voltar')

  end

  scenario 'and can view an specific proposal' do
    candidate = Candidate.create!(email: 'ale@ale.com', password:'123456')
    other_candidate = Candidate.create!(email: 'ze@ze.com', password:'98765432')
        
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    other_profile = CandidateProfile.create!(name: 'José Carlos', academic_background: 'Tecnólogo em ADS', 
                                      description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                      social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: other_candidate.id)
    other_profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

    headhunter = Headhunter.create!(email: 'head@ale.com', password:'12345678')

    job = headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                                  desired_skills: 'Fazer crud e buscar café sem derramar', 
                                  skill_level: 'Estagiário', contract_type: 'Estágio', 
                                  salary: 1500, localization: 'Paulista', 
                                  limit_date: 5.days.from_now)
    job_application = job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')
    job_application2 = job.job_application.create!(candidate_id: other_candidate.id, cover_letter: '1 ano de experiência desenvolvendo web apps...')  

    
    job_proposal = job_application.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR',headhunter_id: headhunter.id)

    job_application2.create_job_proposal(start_date: 10.days.from_now, salary: 1500, benefits:'Vale transporte ou Estacionamento, VR, Convênio médico',
                                        job_roles:'Será responsável pelo protótipo inicial das applicações (MVP)',
                                        job_expectations:'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC',
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR',headhunter_id: headhunter.id)

    visit root_path

    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Propostas enviadas'
    click_on 'Alexandre Moreira Lima'
    
    expect(page).to have_css('h4', text: "#{candidate.candidate_profile.name}" )
    expect(page).to have_content("Vaga: #{job.title}")
    expect(page).to have_content("Descrição da vaga: #{job.description}" )
    expect(page).to have_content("Data de início: #{job_proposal.start_date.strftime('%d/%m/%Y')}")
    expect(page).to have_content("Benefícios: #{job_proposal.benefits}")
    expect(page).to have_content("Atribuições da vaga: #{job_proposal.job_roles}")
    expect(page).to have_content("Expectativas da empresa: #{job_proposal.job_expectations}")
    expect(page).to have_content("Informações adicionais: #{job_proposal.additional_infos}")
    expect(page).to have_link('Voltar')
  end

  scenario 'and return job applications list' do
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

    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'

    click_on 'Propostas enviadas'
    click_on 'Alexandre Moreira Lima'
    click_on 'Voltar'

    expect(current_path).to eq job_path(job.id)

  end

end