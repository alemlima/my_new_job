class CandidateProfilesController < ApplicationController
  before_action :authenticate_candidate!, only: [:new, :create]
    
  def new
    @profile = CandidateProfile.new
  end

  def create
   @profile = CandidateProfile.new(profile_params)
   
    if @profile.save
      redirect_to @profile, notice: 'Perfil cadastrado com sucesso'
      @profile.complete! if @profile.filled_up?
    else
      #erro
      render :new
    end
    
  end

  def show
    @profile = CandidateProfile.find(params[:id])
    
  end

  private

  def profile_params
    params.require(:candidate_profile).permit(:name, :social_name, :academic_background,
                                              :description, :professional_background,
                                              :photo, :social_network, :birth_date, :candidate_id)
  end

end