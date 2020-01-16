class JobProposalsController < ApplicationController

  def show
    @job_proposal = JobProposal.find(params[:id])
  end

  def update
     
  end

end