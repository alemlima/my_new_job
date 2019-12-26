class JobsController < ApplicationController
  before_action :authenticate_headhunter!, only:[:new, :create, :edit, :update]
  before_action :authenticate!, only:[:index, :show]
  before_action :find_job, only:[:show, :edit, :update]
  before_action :headhunter_id, only: [:edit, :update]
  
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.headhunter_id = current_headhunter.id
    
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

  def authenticate!
    unless current_headhunter || current_candidate
      redirect_to root_path
    end

    if candidate_signed_in?
      :authenticate_candidate!
    elsif headhunter_signed_in?
      :authenticate_headhunter!
    end

  end

   def headhunter_id
    @job.headhunter_id = current_headhunter.id
  end


  def job_params
    params.require(:job).permit(:title, :description, :desired_skills,
                                :skill_level, :contract_type, :localization,
                                :salary, :limit_date)
  end

  def find_job
    @job = Job.find(params[:id])
  end
end