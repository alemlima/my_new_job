require 'rails_helper'
describe ' Candidate can search for jobs' do
  xscenario ' successfully' do
    candidate = Candidate.create!(email: 'teste@teste.com', password:'123456')
    profile = CandidateProfile.create!(name: 'Alexandre Moreira Lima', academic_background: 'Tecnólogo em ADS', 
                                       description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                                       social_network: 'linkedin', birth_date: 34.years.ago,
                                       candidate_id: candidate.id)
    profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")
    profile.complete!

    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Vagas'
    
  end

end