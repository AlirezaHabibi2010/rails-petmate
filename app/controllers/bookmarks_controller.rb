class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @pet = Pet.find(params[:pet_id])
    current_user.bookmarks.create(pet: @pet)

    respond_to do |format|
      format.html { redirect_to @pet, notice: "Pet bookmarked successfully." }
      format.text { head :ok }
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(pet_id: params[:pet_id])
    @bookmark.destroy if @bookmark
    redirect_to pet_path(params[:pet_id]), notice: "Bookmark removed successfully."
  end

  def index
    @bookmarks = policy_scope(Bookmark)
  end
end
