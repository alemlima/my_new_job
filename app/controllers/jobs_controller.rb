class JobsController < ApplicationController
  before_action :authenticate_headhunter!, only:[:new, :create, :edit, :update]
  before_action :logged, only: [:index, :show, :search]
  before_action :find_job, only:[:show, :edit, :update, :apply_for, :confirm_application_for]
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
    if headhunter_signed_in? && @job.headhunter_id.eql?(current_headhunter.id)
      @job_applications = JobApplication.where('job_id like ?', "#{@job.id}")
    end
  end

  def search
    @jobs = Job.where('title like ? OR description like ?', "%#{params[:q]}%","%#{params[:q]}%")
    render :job_search_results
  end

  def apply_for
    @job_application = JobApplication.new
  end

  def confirm_application_for
    @job_application = JobApplication.new(params.require(:job_application).permit(:cover_letter))
    @job_application.job_id = @job.id
    @job_application.candidate_id = current_candidate.id
    
    if @job_application.save
      redirect_to job_application_path(@job_application), notice: 'Candidatura aplicada com sucesso'
    else
      render :apply_for
    end
  end

  private

  
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