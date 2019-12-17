require 'rails_helper'

feature 'Visitor open home page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('My New Job')
    expect(page).to have_content('Bem vindo ao My New Job, aqui você encontra seu novo emprego.')
  end
end