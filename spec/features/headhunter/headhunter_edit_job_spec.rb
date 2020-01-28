require 'rails_helper'

feature 'Headhunter edits job' do

  scenario 'but must be logged in' do

    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    
    job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    visit edit_job_path(job)

    expect(current_path).to eq headhunter_session_path

  end

  scenario ' successfully' do

    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    login_as(headhunter, scope: :headhunter)
    Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    visit root_path
    
    click_on 'Vagas'
    click_on 'Estágio Rails'
    click_on 'Editar vaga'

    fill_in 'Descrição', with: 'CRUD, buscar café e trocar a água'
    fill_in 'Faixa salarial', with: 2000

    click_on 'Enviar'

    expect(page).to have_content('Vaga atualizada com sucesso')
    expect(page).to have_content('Descrição da vaga: CRUD, buscar café e trocar a água')
    expect(page).to have_content('Faixa salarial: 2000')

    expect(page).to have_link('Voltar')
  end

  scenario ' and returns to home page' do
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    login_as(headhunter, scope: :headhunter)
    Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)

    visit root_path
    
    click_on 'Vagas'
    click_on 'Estágio Rails'
    click_on 'Editar vaga'

    fill_in 'Descrição', with: 'CRUD, buscar café e trocar a água'
    fill_in 'Faixa salarial', with: 2000

    click_on 'Enviar'
    click_on 'Voltar'
    
    expect(current_path).to eq root_path
    
  end

end
