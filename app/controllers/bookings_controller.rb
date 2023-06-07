class BookingsController < ApplicationController
  before_action :set_pet, only: %i[new create edit show]
  before_action :set_booking, only: %i[edit update confirmation]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.pet = @pet
    @booking.user = current_user
    if @booking.save
      redirect_to booking_confirmation_path(@booking), notice: "Booking was successfully saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      @booking.update({ status: 0 })
      redirect_to pet_path(@booking.pet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end
end
