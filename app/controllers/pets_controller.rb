class PetsController < ApplicationController
  def index
    @pets = policy_scope(Pet)
    authorize @pets
  end

  def show
    @pet = Pet.find(params[:id])
    authorize @pet
  end

  def new
    @pet = Pet.new
    authorize @pet
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    authorize @pet

    if @pet.save
      redirect_to pet_path(@pet), notice: "Pet was successfully saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @pet
  end

  def update
    @pet.update(pet_params)
    authorize @pet

    if @pet.save
      redirect_to pet_path(@pet), notice: "Pet was successfully updated."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :description, :category_id, photos: [])
  end
end
