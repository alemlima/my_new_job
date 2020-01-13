class JobApplicationsController < ApplicationController
  before_action :logged

  def index
    if candidate_signed_in?
      @job_applications = JobApplication.where('candidate_id like ?', "#{current_candidate.id}")
    end

  end

  def show
    
    @job_application = JobApplication.find(params[:id])
    
  end
end
