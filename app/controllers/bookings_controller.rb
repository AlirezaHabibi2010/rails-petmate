class BookingsController < ApplicationController
  def accept
    authorize @booking
    if @booking.update({ confirmed_by_owner: true, declined: false })
      redirect_to pets_owner_requests_list_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def decline
    authorize @booking
    if @booking.update({ declined: true, confirmed_by_owner: false })
      redirect_to pets_owner_requests_list_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end
