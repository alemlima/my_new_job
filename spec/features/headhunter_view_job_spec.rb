require 'rails_helper'

feature 'Headhunter view job' do

  scenario ' but must be logged in' do

    visit jobs_path

    expect(current_path).to eq root_path
    expect(page).to have_content('Você deve estar logado para acessar este recurso')

  end
  
  scenario ' but does not have any job registered' do

    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
    login_as(headhunter, scope: :headhunter)

    visit root_path
    click_on 'Vagas'
    
    expect(page).to have_content('Não existem vagas cadastradas')
  end
  
  scenario ' successfully' do
    
    headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')

    Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                desired_skills: 'Fazer crud e buscar café sem derramar', 
                skill_level: 'Estagiário', contract_type: 'Estágio', 
                salary: 1500, localization: 'Paulista', 
                limit_date: 5.days.from_now, headhunter_id: headhunter.id)
                
    login_as(headhunter, scope: :headhunter)
    
    visit root_path
    
    click_on 'Vagas'
    click_on 'Estágio Rails'

    expect(page).to have_content('Estágio Rails')
    expect(page).to have_content('Descrição da vaga: CRUD e buscar café')
    expect(page).to have_content('Habilidades desejadas: Fazer crud e buscar café sem derramar')
    expect(page).to have_content('Nível: Estagiário')  
    expect(page).to have_content('Contratação: Estágio')
    expect(page).to have_content('Localização: Paulista')
    expect(page).to have_content('Faixa salarial: 1500')
    expect(page).to have_content("Data limite para aplicação: #{5.days.from_now.strftime('%d/%m/%Y')}")

  end

end