class BookmarksController < ApplicationController
  def create
    @pet = Pet.find(params[:pet_id])
    @bookmark = Bookmark.new
    authorize @bookmark

    @bookmark.user = current_user
    @bookmark.pet = @pet
    @bookmark.save!



    head :ok
  end

  def destroy

  end

  private

  def bookmark_params

  end
end
