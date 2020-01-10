class JobApplicationsController < ApplicationController

def show
  
  @job_application = JobApplication.find(params[:id])
  @job = Job.find(@job_application.job_id)

end

end
