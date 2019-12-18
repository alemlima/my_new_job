class JobsController < ApplicationController
  
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to @job, notice: 'Vaga criada com sucesso.'
    else
      #erro
      render :new
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :desired_skills,
                                :skill_level, :contract_type, :localization,
                                :salary, :limit_date, :headhunter_id)
  end

end