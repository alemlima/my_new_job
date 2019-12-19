class JobsController < ApplicationController
  before_action :authenticate_headhunter!, only:[:new, :create]
  
  
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to @job, notice: 'Vaga cadastrada com sucesso.'
    else
      #erro
      render :new
    end
  end
  def show
    @job = Job.find(params[:id])
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :desired_skills,
                                :skill_level, :contract_type, :localization,
                                :salary, :limit_date, :headhunter_id)
  end

end