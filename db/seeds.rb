# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
candidate = Candidate.create!(email: 'candidate@candidate.com', password:'123456')
profile = CandidateProfile.create!(name: 'José Santos', academic_background: 'Tecnólogo em ADS', 
                          description: 'Profissional...', professional_background: 'Profissional com experiencia...',
                          social_network: 'linkedin', birth_date: 34.years.ago,candidate_id: candidate.id)
profile.photo.attach(io: File.open("./spec/support/foto.jpg"), filename: "foto.jpg", content_type: "image/jpg")

headhunter = Headhunter.create!(email: 'head@headhunters.com', password:'12345678')
headhunter.jobs.create!(title: 'Estágio Dev', description: 'CRUD e buscar café', 
                        desired_skills: 'Fazer crud e buscar café sem derramar', 
                        skill_level: 'Estagiário', contract_type: 'Estágio', 
                        salary: 1500, localization: 'Paulista', 
                        limit_date: 5.days.from_now)
headhunter.jobs.create!(title: 'Estágio Rails', description: 'Rails com TDD', 
                        desired_skills: 'Fazer crud e buscar café sem derramar', 
                        skill_level: 'Estagiário', contract_type: 'Estágio', 
                        salary: 1500, localization: 'Paulista', 
                        limit_date: 8.days.from_now)