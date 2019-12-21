require  'rails_helper'

describe 'candidate edits profile'do
  scenario 'successfully' do
    
    candidate = Candidate.create!(email: 'ale@ale.com', password: '12345678')
    profile = CandidateProfile.create!(name: 'Alexandre Lima', candidate_id: candidate.id)

    login_as(candidate, scope: :candidate)

    visit root_path
    
    
    click_on 'Meu perfil'
    click_on 'Editar perfil'

    fill_in 'Nome', with: 'Alexandre Moreira Lima'
    fill_in 'Formação', with: 'Tecnólogo em Análise e Desenvolvimento de Sistemas - Uninove'
    fill_in 'Sobre você', with: 'Profissional com experiência em ....'
    fill_in 'Experiência profissional', with: '4/2017 - Atual - Desenvolvedor Rails - Rebase - 
                                               atuando com desenvolvimento Rails ....'
    fill_in 'Foto', with: 'foto.jpg'
    fill_in 'Linkedin', with: 'linkedin.com/alexandrelima'
    fill_in 'Data de nascimento', with: 34.years.ago

    click_on 'Salvar perfil'

    expect(page).to have_content('Perfil atualizado com sucesso')

    expect(page).to have_css('h3', text: 'Alexandre Moreira Lima')
    expect(page).to have_content('Formação: Tecnólogo em Análise e Desenvolvimento de Sistemas - Uninove')

    expect(page).to have_link('Voltar')
  end
end
