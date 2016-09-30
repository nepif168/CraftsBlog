class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.create(favorite_params)
    redirect_to blog_path(@favorite.blog_id)
  end

  def destroy
    @favorite = Favorite.where(user_id: current_user.id, blog_id: params[:blog_id]).first
    @favorite.destroy
    redirect_to blog_path(params[:blog_id])
  end

  private
    def favorite_params
      params.require(:favorite).permit(:user_id, :blog_id)
    end
end
