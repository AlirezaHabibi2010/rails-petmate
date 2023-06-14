class BookingsController < ApplicationController
  before_action :set_pet, only: %i[new create show]
  before_action :set_booking, only: %i[edit update confirmation chatroom set_booking accepted declined ongoing completed deactivate]

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.pet = @pet
    @booking.user = current_user
    authorize @booking

    if @booking.save
      @booking.messages.create(content: params["message"].present? ? params["message"] : "default message", user: current_user)
      redirect_to confirmation_booking_path(@booking), notice: "Booking was successfully saved."
    else
      render :new, status: :unprocessable_entity, class:"btn"
    end
  end

  def deactivate
    authorize @booking
    @booking.deactivate!
    redirect_back_or_to inbox_path, notice: "Booking was successfully deleted."
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking
    if @booking.update(booking_params)
      @booking.update({ status: 0 })
      redirect_to pet_path(@booking.pet), notice: "Booking was successfully edited."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def requests_list
    @bookings = policy_scope(Booking).order(start_time: :asc)
    authorize @bookings
    @declined = @bookings.where({ status: 2 })
    @accepted = @bookings.where({ status: 1 })
    @pending_requests = @bookings.where({ status: 0 })
    @completed = @bookings.where(status: 4)
  end

  def inbox
    @bookings = policy_scope(Booking, policy_scope_class: BookingPolicy::Scopeinbox).order(updated_at: :asc)
    authorize @bookings
    @completed = @bookings.where({ status: 4 })
    @ongoing = @bookings.where({ status: 3 })
    @declined = @bookings.where({ status: 2 })
    @accepted = @bookings.where({ status: 1 })
    @pending_requests = @bookings.where({ status: 0 })
  end

  def accepted
    authorize @booking
    if @booking.accepted!
      redirect_to chatroom_booking_path(@booking), notice: "Booking has been accepted!"
    else
      raise
      render :chatroom, notice: 'Booking could not be accepted - please try again'
    end
  end

  def declined
    authorize @booking
    if @booking.declined!
      redirect_to chatroom_booking_path(@booking), notice: "Booking has been declined!"
    else
      render :chatroom, status: :unprocessable_entity, notice: 'Booking could not be accepted - please try again'
    end
  end

  def ongoing
    authorize @booking
    if @booking.ongoing!
      redirect_to chatroom_booking_path(@booking), notice: "Pet is going to have fun!"
    else
      render :chatroom, status: :unprocessable_entity, notice: 'Booking could not be ongoing - please try again'
    end
  end

  def completed
    authorize @booking
    if @booking.completed!
      redirect_to chatroom_booking_path(@booking), notice: "Pet has been returned!"
    else
      render :chatroom, status: :unprocessable_entity, notice: 'Booking could not be completed - please try again'
    end
  end

  def confirmation
    authorize @booking
  end

  def chatroom
    authorize @booking
    marks_as_read_message
  end

  def marks_as_read_message
    @messages = @booking.messages
    @messages.where.not(user: current_user).update({ read: true })
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
