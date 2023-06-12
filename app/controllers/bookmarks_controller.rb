class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @pet = Pet.find(params[:pet_id])
    @bookmark = current_user.bookmarks.create(pet: @pet)

    authorize @bookmark
    respond_to do |format|
      format.html { redirect_back_or_to @pet, notice: "Pet added to favorite successfully." }
      format.text { head :ok }
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if @bookmark
      @bookmark.destroy
      respond_to do |format|
        format.html { redirect_back_or_to @pet, notice: "Pet removed from favorite successfully." }
        format.text { head :ok }
      end
    else
      render :nothing
    end
  end

  def index
    @bookmarks = policy_scope(Bookmark)
  end
end
