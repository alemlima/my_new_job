class CandidateProfilesController < ApplicationController
  before_action :authenticate_candidate!, only: [:new, :create]
  before_action :find_profile, only: [:show, :edit, :update]
    
  def new
    @profile = CandidateProfile.new
  end

  def create
   @profile = CandidateProfile.new(profile_params)
   
    if @profile.save
      @profile.complete! if @profile.filled_up?
      redirect_to @profile, notice: 'Perfil cadastrado com sucesso'
    else
      #erro
      render :new
    end
  end

  def show
  end

  def edit
  end
  
  def update
    
    if @profile.update(profile_params)
      @profile.complete! if @profile.filled_up?
      redirect_to @profile, notice: 'Perfil atualizado com sucesso'
    else
      render :edit
    end
  end

  private

  def find_profile
    @profile = CandidateProfile.find(params[:id])
  end

  def profile_params
    params.require(:candidate_profile).permit(:name, :social_name, :academic_background,
                                              :description, :professional_background,
                                              :photo, :social_network, :birth_date, :candidate_id)
  end

end