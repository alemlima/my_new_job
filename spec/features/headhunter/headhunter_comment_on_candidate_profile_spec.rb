require 'rails_helper'

describe 'Headhunter can comment on candidate profile' do
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

    job.job_application.create!(candidate_id: candidate.id, cover_letter: '6 meses de experiência desenvolvendo web apps...')

    visit root_path
      
    click_on 'Acessar como Headhunter'
  
    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password
    click_on 'Login'
  
    click_on 'Vagas'
    click_on 'Estágio Dev'
    click_on 'Ver perfil de Alexandre Moreira Lima'
    click_on 'Escrever comentário'

    fill_in 'Comentário', with: 'Excelente candidato!'
    click_on 'Enviar comentário'

    expect(page).to have_content('Comentário enviado com sucesso!')
    expect(page).to have_content('Comentário: Excelente candidato!')

  end
end