class JobProposalsController < ApplicationController
  before_action :logged, only: [:index, :show]
  #before_action :authenticate_candidate!, only: [:update]
  before_action :find_job_proposal, only: [:show, :decline, :confirm_declination_for]

  def index
    if candidate_signed_in?
      @job_proposals = JobProposal.joins(:job_application).where(job_applications: {candidate_id: current_candidate.id}).where(status: :submitted)
    elsif headhunter_signed_in?
      @job_proposals = JobProposal.where('headhunter_id like ?', "#{current_headhunter.id}" )
    end
  end

  def show
  end

  def decline
  end

  def confirm_declination_for
    if @job_proposal.update(params.require(:job_proposal).permit(:feedback))
      @job_proposal.rejected!
      redirect_to job_proposals_path, notice: 'Proposta rejeitada com sucesso!'
    else
      render :decline  
    end
  end

  def update
     
  end

  private

  def find_job_proposal
    @job_proposal = JobProposal.find(params[:id])
  end

end