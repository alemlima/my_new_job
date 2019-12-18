require 'rails_helper'
  feature 'Headhunter register a new job position' do
    scenario 'successfully' do
      
      visit root_path
      click_on 'Vagas'
      click_on 'Cadastrar nova vaga'

      fill_in 'Título', with: 'Estágio em Desenvolvimento de Software'
      fill_in 'Descrição', with: 'Empresa Busca estagiária(o) para integrar o time de Devs,
                                  desenvolvendo software com qualidade, segurança e boas práticas'
      fill_in 'Habilidades desejadas', with: 'Boa lógica de programação, noções de boas práticas
                                              em desenvolvimento de software, noções de metodologia ágil'
      fill_in 'Faixa salarial', with: 2000
      select 'Estágio', from: 'Nível'
      select 'Estágio', from: 'Contratação'
      fill_in 'Data limite', with: 2.days.from_now
      fill_in 'Localização', with: 'Vila Madalena'

      click_on('Cadastrar vaga')

      expect(page).to have_content('Vaga cadastrada com sucesso')
      expect(page).to have_css('h3', text: 'Estágio em Desenvolvimento de Software')

      expect(page).to have_link('Voltar')
    end
  end