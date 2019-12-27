require 'rails_helper'

describe ' Candidate can search for jobs' do

  scenario ' but must be logged in' do

    visit search_jobs_path

    expect(current_path).to eq root_path
    
  end

  scenario ' with one exact result matching in title' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
    
    other_job = Job.create!(title: 'Estágio Ruby', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
            
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vagas', with: "#{job.title}"
    click_on 'Buscar'

    expect(page).to have_content('1 vaga encontrada:')
    expect(page).to have_content(job.title)
    expect(page).not_to have_content(other_job.title)
    expect(page).to have_link('Voltar')

  end

  scenario ' with one partial result matching in title' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
    
    other_job = Job.create!(title: 'Estágio Ruby', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
            
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vagas', with: 'Rails'
    click_on 'Buscar'

    expect(page).to have_content('1 vaga encontrada:')
    expect(page).to have_content(job.title)
    expect(page).not_to have_content(other_job.title)
    expect(page).to have_link('Voltar')
  end

  scenario ' with more than one partial result matching in title' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
    
    other_job = Job.create!(title: 'Estágio Ruby', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
            
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vagas', with: 'Estágio'
    click_on 'Buscar'

    expect(page).to have_content(job.title)
    expect(page).to have_content(other_job.title)
    expect(page).to have_link('Voltar')

  end

  scenario ' with more than one exact result matching in title' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
    
    other_job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
            
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vagas', with: 'Estágio Rails'
    click_on 'Buscar'

    expect(page).to have_content('2 vagas encontradas:')
    expect(page).to have_content(job.title)
    expect(page).to have_content(other_job.title)
    expect(page).to have_link('Voltar')
    
  end

  scenario ' with one exact result matching in description' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
    
    other_job = Job.create!(title: 'Estágio Ruby', description: 'Lógica e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
            
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vagas', with: "#{job.description}"
    click_on 'Buscar'

    expect(page).to have_content('1 vaga encontrada:')
    expect(page).to have_content(job.description)
    expect(page).not_to have_content(other_job.title)
    expect(page).to have_link('Voltar')

  end

  scenario ' with more than one exact result matching in description' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
    
    other_job = Job.create!(title: 'Estágio Ruby', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
            
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vagas', with: "#{job.description}"
    click_on 'Buscar'

    expect(page).to have_content('2 vagas encontradas:')
    expect(page).to have_content(job.description)
    expect(page).to have_content(other_job.description)
    expect(page).to have_link('Voltar')

  end

  scenario ' with more than one partial results matching in title or description' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
    
    other_job = Job.create!(title: 'Estágio Ruby', description: 'Rails e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
            
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vagas', with: 'Rails'
    click_on 'Buscar'

    expect(page).to have_content('2 vagas encontradas:')
    expect(page).to have_content(job.title)
    expect(page).to have_content(other_job.title)
    expect(page).to have_link('Voltar')

  end

  scenario ' with no results matching in title or description' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
    
    other_job = Job.create!(title: 'Estágio Ruby', description: 'Rails e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
            
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vagas', with: 'Desenvolvedor'
    click_on 'Buscar'

    expect(page).to have_content('Nenhuma vaga encontrada, por favor tente novamente.')
    expect(page).not_to have_content(job.title)
    expect(page).not_to have_content(other_job.title)
    expect(page).to have_link('Voltar')

  end

  scenario ' and return to jobs list' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
    
    other_job = Job.create!(title: 'Estágio Ruby', description: 'Rails e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
            
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vagas', with: 'Desenvolvedor'
    click_on 'Buscar'
    click_on 'Voltar'
    
    expect(current_path).to eq jobs_path
  end

end