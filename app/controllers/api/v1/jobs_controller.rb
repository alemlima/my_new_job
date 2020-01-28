class Api::V1::JobsController < Api::V1::ApiController
  def show
    @job = Job.find(params[:id])
    render json: @job.as_json(except: [:headhunter_id, :created_at, :updated_at]), status: :ok
  end

  def index
    @jobs = Job.all
    unless @jobs.empty?
      render json: @jobs.as_json(except: [:headhunter_id, :created_at, :updated_at]), status: :ok
    else
      render json: {}, status: :no_content  
    end
    
  end

end