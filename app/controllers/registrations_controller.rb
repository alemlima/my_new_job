class RegistrationsController < Devise::RegistrationsController
  
  private

  def after_sign_up_path_for(candidate)
    new_candidate_profile_path
  end
end