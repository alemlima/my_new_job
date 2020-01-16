class JobProposalsController < ApplicationController
  before_action :logged, only: [:index, :show]
  before_action :authenticate_candidate!, only: [:update]

  def index
    if candidate_signed_in?
      @job_proposals = JobProposal.joins(:job_application).where(job_applications: {candidate_id: current_candidate.id})
    end
  end

  def show
    @job_proposal = JobProposal.find(params[:id])
  end

  def update
     
  end

end