require 'rails_helper'

describe 'Headhunter send job proposal to candidate' do
  
  scenario 'and must fill in obrigatory fields' do
    
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
      job_application= job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')

    visit root_path
      
    click_on 'Acessar como Headhunter'
  
    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'
  
    click_on 'Vagas'
    click_on 'Estágio Dev'
    click_on 'Ver candidatura de Alexandre Moreira Lima'
    click_on 'Enviar proposta'
  
    fill_in 'Data de início', with: 10.days.from_now
    fill_in 'Salário', with: 1500
    fill_in 'Benefícios', with: 'Vale transporte ou Estacionamento, VR, Convênio médico'

    click_on 'Enviar'

    expect(page).to have_content('Atribuições da vaga deve ser preenchido.')
    expect(page).to have_content('Expectativas da empresa deve ser preenchido.')
      
      

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

    headhunter.jobs.create!(title: 'Estágio web', description: 'CRUD, buscar café, e um pouco de CSS', 
                                    desired_skills: 'Fazer crud, buscar café sem derramar e arrumar CSS', 
                                    skill_level: 'Estagiário', contract_type: 'Estágio', 
                                    salary: 1500, localization: 'Vila Mariana', 
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
    click_on 'Enviar proposta'

    fill_in 'Data de início', with: 10.days.from_now
    fill_in 'Salário', with: 1500
    fill_in 'Benefícios', with: 'Vale transporte ou Estacionamento, VR, Convênio médico'
    fill_in 'Atribuições da vaga', with: 'Será responsável pelo protótipo inicial das applicações (MVP)'
    fill_in 'Expectativas da empresa', with: 'Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC'
    fill_in 'Informações adicionais', with: 'VR: R$20, Convênio médico: Porto Seguro, PLR'

    click_on 'Enviar'
    
      expect(page).to have_content('Proposta enviada com sucesso!')
      expect(page).to have_css('h4', text:"#{profile.name}")
      expect(page).to have_content("Vaga: #{job.title}")
      expect(page).to have_content("Descrição da vaga: #{job.description}" )
      expect(page).to have_content("Data de início: #{10.days.from_now.strftime('%d/%m/%Y')}")
      expect(page).to have_content('Benefícios: Vale transporte ou Estacionamento, VR, Convênio médico')
      expect(page).to have_content('Atribuições da vaga: Será responsável pelo protótipo inicial das applicações (MVP)')
      expect(page).to have_content('Expectativas da empresa: Consiga trabalhar com metodologias ágeis, TDD e seguir o padrão MVC')
      expect(page).to have_content('Informações adicionais: VR: R$20, Convênio médico: Porto Seguro, PLR')
      expect(page).to have_link('Voltar')
    
  end
end