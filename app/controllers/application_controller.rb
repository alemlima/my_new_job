class ApplicationController < ActionController::Base
  
  private

  def after_sign_in_path_for(candidate) 
    if candidate_signed_in?
      if current_candidate.candidate_profile.nil?
        new_candidate_profile_path
      elsif current_candidate.candidate_profile.incomplete? 
        edit_candidate_profile_path(current_candidate.candidate_profile.id)
      else
        super
      end
    else
      super
    end
  end
  
  def logged
    unless current_headhunter || current_candidate
      redirect_to root_path, notice: 'Você deve estar logado para acessar este recurso'
    end
  end
end
