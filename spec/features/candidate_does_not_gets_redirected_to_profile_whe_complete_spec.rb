require 'rails_helper'

describe 'candidate creates profile' do
  scenario ' and fill in all fields' do
    
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       photo:'foto.jpg', social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.complete!
    
    visit root_path
    click_on 'Acessar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Login'

    expect(current_path).to eq root_path

  end
end