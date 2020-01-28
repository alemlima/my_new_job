require 'rails_helper'
  
feature 'Headhunter register a new job position' do
    
    scenario ' but must be logged in' do
      visit new_job_path

      expect(current_path).to eq headhunter_session_path
      
    end

    scenario 'successfully' do
      
      headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
      login_as(headhunter, scope: :headhunter)

      visit root_path
      click_on 'Vagas'
      click_on 'Cadastrar nova vaga'

      fill_in 'Título', with: 'Estágio em Desenvolvimento de Software'
      fill_in 'Descrição', with: 'Empresa Busca estagiária(o) para integrar o time de Devs,
                                  desenvolvendo software com qualidade, segurança e boas práticas'
      fill_in 'Habilidades desejadas', with: 'Boa lógica de programação, noções de boas práticas
                                              em desenvolvimento de software, noções de metodologia ágil'
      fill_in 'Faixa salarial', with: 2000
      choose 'job_skill_level_estagiário'
      choose 'job_contract_type_estágio'
      fill_in 'Data limite', with: 2.days.from_now
      fill_in 'Localização', with: 'Vila Madalena'

      click_on('Enviar')

      expect(page).to have_content('Vaga cadastrada com sucesso')
      expect(page).to have_css('h3', text: 'Estágio em Desenvolvimento de Software')

      expect(page).to have_link('Voltar')
    
    end


    scenario ' and return to home page' do
    
      headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
      login_as(headhunter, scope: :headhunter)

      visit root_path
      click_on 'Vagas'
      click_on 'Cadastrar nova vaga'

      fill_in 'Título', with: 'Estágio em Desenvolvimento de Software'
      fill_in 'Descrição', with: 'Empresa Busca estagiária(o) para integrar o time de Devs,
                                  desenvolvendo software com qualidade, segurança e boas práticas'
      fill_in 'Habilidades desejadas', with: 'Boa lógica de programação, noções de boas práticas
                                              em desenvolvimento de software, noções de metodologia ágil'
      fill_in 'Faixa salarial', with: 2000
      choose 'job_skill_level_estagiário'
      choose 'job_contract_type_estágio'
      fill_in 'Data limite', with: 2.days.from_now
      fill_in 'Localização', with: 'Vila Madalena'

      click_on('Enviar')
      click_on('Voltar')

      expect(current_path).to eq root_path
    end
    
    
  end