class JobApplicationsController < ApplicationController
  before_action :authenticate_candidate!, only: [:index]
  before_action :authenticate_headhunter!, only: [:decline, :confirm_declination_for, :send_proposal_for, :confirm_proposal_for]
  before_action :find_job_application, only:[:show, :decline, :confirm_declination_for, :send_proposal_for, :confirm_proposal_for]
  

  def index
      @job_applications = JobApplication.where('candidate_id like ?', "#{current_candidate.id}")
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

  def send_proposal_for
    @job_proposal = JobProposal.new
  end

  def confirm_proposal_for
    @job_proposal = @job_application.create_job_proposal(params.require(:job_proposal).permit(:start_date, :salary, :benefits,
                                                                                              :job_roles, :job_expectations, :additional_infos))
    @job_proposal.headhunter_id = current_headhunter.id                                                                                          
    if @job_proposal.save
      redirect_to job_proposal_path(@job_proposal), notice: 'Proposta enviada com sucesso!'
    else
      render :send_proposal_for
    end
  end

  private

  def find_job_application
    @job_application = JobApplication.find(params[:id])
  end

end
