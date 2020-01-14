class JobApplicationsController < ApplicationController
  before_action :authenticate_candidate!, only: [:index]
  before_action :authenticate_headhunter!, only: [:decline, :confirm_declination_for]
  before_action :find_job_application, only:[:show, :decline, :confirm_declination_for]
  

  def index
    #if candidate_signed_in?
      @job_applications = JobApplication.where('candidate_id like ?', "#{current_candidate.id}")
    #end

  end

  def show
  end

  def decline
  end

  def confirm_declination_for
    if @job_application.update(params.require(:job_application).permit(:feedback))
      @job_application.declined!
      redirect_to @job_application, notice: 'Candidatura rejeitada com sucesso'
    else
      render :decline
    end
  end

  private

  def find_job_application
    @job_application = JobApplication.find(params[:id])
  end

end
