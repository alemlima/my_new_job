require 'rails_helper'

describe 'Headhunter view job proposal feedback' do
  scenario 'but candidate does not provided a feedback' do
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
    job_proposal.rejected!

    visit root_path
    
    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password

    click_on 'Login'

    click_on 'Propostas enviadas'
    click_on 'Alexandre Moreira Lima'

    expect(page).to have_css('h4', text: "#{candidate.candidate_profile.name}")
    expect(page).to have_content("Vaga: #{job.title}")
    expect(page).to have_content("Descrição da vaga: #{job.description}" )
    expect(page).to have_content("Data de início: #{job_proposal.start_date.strftime('%d/%m/%Y')}")
    expect(page).to have_content("Benefícios: #{job_proposal.benefits}")
    expect(page).to have_content("Atribuições da vaga: #{job_proposal.job_roles}")
    expect(page).to have_content("Expectativas da empresa: #{job_proposal.job_expectations}")
    expect(page).to have_content("Informações adicionais: #{job_proposal.additional_infos}")
    expect(page).to have_css('p', text: 'O candidato não enviou nenhum feedback sobre esta proposta')
    expect(page).to have_link('Voltar')

  end

  scenario 'successfully' do
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
                                        additional_infos:'VR: R$20, Convênio médico: Porto Seguro, PLR',headhunter_id: headhunter.id,
                                        feedback: 'Caro recrutador, agradeço a proposta mas ela não atende minhas espectativas. Muito obrigado.')
    job_proposal.rejected!

    visit root_path
    
    click_on 'Acessar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password

    click_on 'Login'

    click_on 'Propostas enviadas'
    click_on 'Alexandre Moreira Lima'

    expect(page).to have_css('h4', text: "#{candidate.candidate_profile.name}")
    expect(page).to have_content("Vaga: #{job.title}")
    expect(page).to have_content("Descrição da vaga: #{job.description}" )
    expect(page).to have_content("Data de início: #{job_proposal.start_date.strftime('%d/%m/%Y')}")
    expect(page).to have_content("Benefícios: #{job_proposal.benefits}")
    expect(page).to have_content("Atribuições da vaga: #{job_proposal.job_roles}")
    expect(page).to have_content("Expectativas da empresa: #{job_proposal.job_expectations}")
    expect(page).to have_content("Informações adicionais: #{job_proposal.additional_infos}")
    expect(page).to have_css('p', text: 'Caro recrutador, agradeço a proposta mas ela não atende minhas espectativas. Muito obrigado.')
    expect(page).to have_link('Voltar')

  end
end
