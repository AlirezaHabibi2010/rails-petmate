class MessagesController < ApplicationController
  before_action :set_booking, only: %i[create]

  def create
    @message = Message.new(message_params)
    @message.booking = @booking
    @message.user = current_user
    authorize @booking
    if @message.save
      ChatroomChannel.broadcast_to(
        @booking,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

end
