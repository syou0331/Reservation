class BookingsController < ApplicationController
  protect_from_forgery
  def index
    @bookings = Booking.all
  end

  def new
  end

  def create

  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:notice] = "予約を削除しました"
    redirect_to :bookings
  end
  

end
