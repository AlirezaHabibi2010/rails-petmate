class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @pets = policy_scope(Pet)
    if params[:search].present?
      if params[:search][:type].present?
        @pets = @pets.search_by_type(params[:search][:type])
      end
      if params[:search][:where].present?
        @pets = @pets.search_by_address(params[:search][:where])
      end
      if params[:search][:from].present? && params[:search][:to].present?
        start_date = Date.parse(params[:search][:from])
        end_date = Date.parse(params[:search][:to])
        @pets = @pets.find_without_bookings_between_dates(start_date, end_date)
      end
    end
  end

  def list
    if current_user.admin
      @pets = policy_scope(Pet)
    else
      @pets = policy_scope(Pet).where(user: current_user).order(:name)
    end
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
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    authorize @pet

    if @pet.save
      redirect_to pet_path(@pet), notice: "Pet was successfully updated."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def deactivate
    @pet = Pet.find(params[:id])
    authorize @pet
    @pet.deactivate!

    redirect_back_or_to pet_path(@pet), notice: "Pet was successfully deleted."
  end


  def owner_requests_list
    @pets = policy_scope(Pet).where(user: current_user).order(:name)

    @declined = Array.new
    @accepted = Array.new
    @pending_requests = Array.new
    @pets.each do |pet|
      @declined_list = Array.new
      @accepted_list = Array.new
      @pending_requests_list = Array.new
      pet.bookings.where('start_time >= ?', Date.today).order(:start_time).each do |booking|
        if booking.status == 2
          @declined_list << booking
        elsif booking.status == 1
          @accepted_list << booking
        else
          @pending_requests_list << booking
        end
      end
      @declined <<  [pet, @declined_list] if !@declined_list.empty?
      @accepted <<  [pet, @accepted_list] if !@accepted_list.empty?
      @pending_requests <<  [pet, @pending_requests_list] if !@pending_requests_list.empty?
    end
    authorize @pets
  end


  private

  def pet_params
    params.require(:pet).permit(:name, :description, :category_id, photos: [])
  end
end
