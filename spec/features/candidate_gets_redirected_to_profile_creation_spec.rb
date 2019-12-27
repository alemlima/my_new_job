require 'rails_helper'

describe ' Candidate creates account and gets redirected to fill profile' do
  scenario ' successfully' do

    visit root_path
    click_on 'Quero uma vaga'

    fill_in 'Email', with: 'ale@ale.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    
    click_on 'Criar conta'

    expect(current_path).to eq new_candidate_profile_path
  end

  scenario ' and must fill in at least the name on the profile to continue' do

    visit root_path
    click_on 'Quero uma vaga'

    fill_in 'Email', with: 'ale@ale.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    
    click_on 'Criar conta'

    click_on 'Salvar perfil'

    expect(page).to have_content('Nome deve ser preenchido')

    expect(page).to have_link('Voltar')

  end

  scenario '  fill in the name and creates a profile successfully' do

    visit root_path
    click_on 'Quero uma vaga'

    fill_in 'Email', with: 'ale@ale.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    
    click_on 'Criar conta'

    fill_in 'Nome', with: 'Alexandre Lima'

    click_on 'Salvar perfil'

    expect(page).to have_content('Perfil cadastrado com sucesso')
    expect(page).to have_css('h3', text: 'Alexandre Lima')
    expect(page).to have_link('Voltar')
  
  end

  scenario ' and return to home page' do

    visit root_path
    click_on 'Quero uma vaga'

    fill_in 'Email', with: 'ale@ale.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    
    click_on 'Criar conta'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

end