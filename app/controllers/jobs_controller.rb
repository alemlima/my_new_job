class JobsController < ApplicationController
  before_action :authenticate_headhunter!, only:[:new, :create]
  before_action :find_job, only:[:show, :edit, :update]
  
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

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Vaga atualizada com sucesso'
    else
      render :edit
    end
  end

  def show
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :desired_skills,
                                :skill_level, :contract_type, :localization,
                                :salary, :limit_date, :headhunter_id)
  end

  def find_job
    @job = Job.find(params[:id])
  end
end