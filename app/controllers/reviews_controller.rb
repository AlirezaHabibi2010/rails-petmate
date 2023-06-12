class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    authorize @review

    if @review.save
      redirect_back_or_to chatroom_booking_path(@booking), notice: "Review was successfully created."
    else
      render "bookings/chatroom", status: :unprocessable_entity, notice: "Review was failed."
    end
  end

  def edit
    authorize @review
  end

  def destroy
    @review = current_user.reviews.find_by(pet_id: params[:pet_id])
    @review.destroy if @review
    redirect_to pet_path(params[:pet_id]), notice: "Review removed successfully."
  end

  def update
    authorize @review
    if @review.update(review_params)
      redirect_to pet_path(@review.pet), notice: "Review was successfully edited."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
