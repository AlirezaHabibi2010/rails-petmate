class PetsController < ApplicationController
  def index
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    if @pet.save
      redirect_to pet_path(@pet), notice: "Pet was successfully saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :description, :category_id, photos: [])
  end
end
