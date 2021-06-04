class FavoritesController < ApplicationController
  before_action :authenticate_user!
  # before_action :book_params
  # POST /books/:book_id/favorites
  # POST /favorites.json
  def create
    # if !Favorite.find(book_id: params[:book_id], user_id: current_user.id).exists?
      @book = Book.find(params[:book_id])
      favorite = current_user.favorites.build(:book_id => params[:book_id])
      favorite.save
      # Favorite.create(user_id: current_user.id, book_id: params[:id])
      # redirect_to request.referer
    # end
  end
  

  # DELETE /books/:book_id/favorites/
  def destroy
    # if Favorite.find(book_id: params[:book_id], user_id: current_user.id).exists?
      @book = Book.find(params[:book_id])
      favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
      favorite.destroy
      # Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
      # redirect_to request.referer
    # end
  end
  
  # def book_params
  #   @book = Book.find(params[:id])
  # end
end
