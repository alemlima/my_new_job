require 'rails_helper'
  describe 'Job management' do
    context 'show' do
      it 'Return a job correctly' do
      
        headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
        
        job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                    desired_skills: 'Fazer crud e buscar café sem derramar', 
                    skill_level: 'Estagiário', contract_type: 'Estágio', 
                    salary: 1500, localization: 'Paulista', 
                    limit_date: 5.days.from_now, headhunter_id: headhunter.id)
        
        get api_v1_job_path(job.id)

        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(:ok)
        expect(json[:title]).to eq(job.title)
        expect(json[:description]).to eq(job.description)
        expect(json[:desired_skills]).to eq(job.desired_skills)
        expect(json[:skill_level]).to eq(job.skill_level)
        expect(json[:contract_type]).to eq(job.contract_type)
        expect(json[:localization]).to eq(job.localization)
        expect(json[:limit_date]).to eq(job.limit_date.strftime('%Y-%m-%d'))  

      end
      
      it 'should return 404 error if the record can not be found' do
        get api_v1_job_path(id: 555)

        json = JSON.parse(response.body, symbolize_names: :true)

        expect(response).to have_http_status(:not_found)
        expect(json[:message]).to eq('Sorry, we can not found the record you are looking for.')
      end

    end
    context 'index' do
      it 'should return a list o jobs' do
      
        headhunter = Headhunter.create!(email: 'ale@ale.com', password:'12345678')
        
        job = Job.create!(title: 'Estágio Rails', description: 'CRUD e buscar café', 
                    desired_skills: 'Fazer crud e buscar café sem derramar', 
                    skill_level: 'Estagiário', contract_type: 'Estágio', 
                    salary: 1500, localization: 'Paulista', 
                    limit_date: 5.days.from_now, headhunter_id: headhunter.id)

        other_job = Job.create!(title: 'Estágio Web', description: 'Buscar café', 
                      desired_skills: 'Buscar café sem derramar', 
                      skill_level: 'Estagiário', contract_type: 'Estágio', 
                      salary: 1200, localization: 'Vila Madalena', 
                      limit_date: 6.days.from_now, headhunter_id: headhunter.id)
        
        get api_v1_jobs_path

        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(:ok)
        expect(json[0][:title]).to eq(job.title)
        expect(json[0][:description]).to eq(job.description)
        expect(json[0][:desired_skills]).to eq(job.desired_skills)
        expect(json[0][:skill_level]).to eq(job.skill_level)
        expect(json[0][:contract_type]).to eq(job.contract_type)
        expect(json[0][:localization]).to eq(job.localization)
        expect(json[0][:limit_date]).to eq(job.limit_date.strftime('%Y-%m-%d'))  

        expect(json[1][:title]).to eq(other_job.title)
        expect(json[1][:description]).to eq(other_job.description)
        expect(json[1][:desired_skills]).to eq(other_job.desired_skills)
        expect(json[1][:skill_level]).to eq(other_job.skill_level)
        expect(json[1][:contract_type]).to eq(other_job.contract_type)
        expect(json[1][:localization]).to eq(other_job.localization)
        expect(json[1][:limit_date]).to eq(other_job.limit_date.strftime('%Y-%m-%d'))  
  
      end
      it 'should return no content status if there are no jobs' do
      
        get api_v1_jobs_path
        
        expect(response).to have_http_status(:no_content)

      end
    end
  end
