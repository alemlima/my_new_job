class ApplicationController < ActionController::Base
  
  private

  def after_sign_in_path_for(candidate) 
    if candidate_signed_in?
      unless current_candidate.candidate_profile.complete? 
        edit_candidate_profile_path(candidate)
      else
        super
      end
    else
      super
    end
  end
  
  
end
