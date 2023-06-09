class BookingsController < ApplicationController
  before_action :set_pet, only: %i[new create show]
  before_action :set_booking, only: %i[edit update confirmation chatroom set_booking, unread_message_number]

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
      redirect_to booking_confirmation_path(@booking), notice: "Booking was successfully saved."
    else
      render :new, status: :unprocessable_entity
    end
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
      render :new, status: :unprocessable_entity
    end
  end

  def requests_list # for renter
    @bookings = policy_scope(Booking)
    authorize @bookings
    @declined = @bookings.where({ status: 2 })
    @accepted = @bookings.where({ status: 1 })
    @pending_requests = @bookings.where({ status: 0 })
  end

  def inbox # for renter
    @bookings = policy_scope(Booking, policy_scope_class: BookingPolicy::Scopeinbox).order(:updated_at)

    authorize @bookings
    @completed = @bookings.where({ status: 4 })
    @ongoing = @bookings.where({ status: 3 })
    @declined = @bookings.where({ status: 2 })
    @accepted = @bookings.where({ status: 1 })
    @pending_requests = @bookings.where({ status: 0 })
  end

  def decline
    authorize @booking
    if @booking.update({ declined: true, confirmed_by_owner: false })
      redirect_to pets_owner_requests_list_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    authorize @booking
    if @booking.update({ status: 1})
      redirect_to pets_owner_requests_list_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation
    authorize @booking
  end

  def chatroom
    authorize @booking
    @status = status(@booking)
    @message = Message.new
    read_message
  end

  def status(booking)
    status = "pending"

    case booking.status
    when 0
      "pending"
    when 1
      "accepted"
    when 2
      "declines"
    when 3
      "ongoing"
    when 4
      "completed"
    end
  end

  def read_message
    @messages = @booking.messages
    @messages.where.not(user: current_user).update({ read: true })
  end

  def unread_message_number
    @messages = @booking.messages
    return @messages.where.not(user: current_user, read: false).count
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
