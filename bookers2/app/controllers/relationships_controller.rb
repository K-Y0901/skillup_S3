class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  # def create
  #   # user = User.find(params[:id])
  #   # current_user.follow(user)
  #   current_user.follow(params[:id])
  #   redirect_to request.referer
  # end

  # def destroy
  #   # user = User.find(params[:id])
  #   # current_user.unfollow(user)
  #   current_user.unfollow(params[:id])
  #   redirect_to request.referer
  # end
  
  
  
  
  def follow
    current_user.follow(params[:id])
    redirect_to request.referer
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to request.referer
  end
  
  
end



