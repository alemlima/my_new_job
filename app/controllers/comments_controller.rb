class CommentsController < ApplicationController
  def new
    @profile = CandidateProfile.find(params[:candidate_profile_id])
    @comment = Comment.new
  end
  
  def create
    @profile = CandidateProfile.find(params[:candidate_profile_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.candidate_profile_id = @profile.id
    @comment.headhunter_id = current_headhunter.id
    if @comment.save
      redirect_to candidate_profile_path(@profile.id), notice: 'Comentário enviado com sucesso!'
    else
      render :new
    end
  end
end