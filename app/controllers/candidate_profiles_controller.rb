class CandidateProfilesController < ApplicationController
  before_action :authenticate_candidate!, only: [:new, :create, :edit, :update]
  after_action :profile_complete, only: [:create, :edit, :update]
  before_action :find_profile, only: [:show, :edit, :update]
  before_action :candidate_id, only: [:show, :edit, :update]

  def new
    @profile = CandidateProfile.new
  end

  def create
   @profile = CandidateProfile.new(profile_params)
   @profile.candidate_id = current_candidate.id
   
    if @profile.save
      redirect_to @profile, notice: 'Perfil cadastrado com sucesso'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end
  
  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: 'Perfil atualizado com sucesso'
    else
      render :edit
    end
  end

  private

  def profile_complete
    @profile.complete! if @profile.filled_up?
  end

  def candidate_id
    @profile.candidate_id = current_candidate.id
  end

  def find_profile
    @profile = CandidateProfile.find(params[:id])
  end

  def profile_params
    params.require(:candidate_profile).permit(:name, :social_name, :academic_background,
                                              :description, :professional_background,
                                              :photo, :social_network, :birth_date)
  end

end