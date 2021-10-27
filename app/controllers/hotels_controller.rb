class HotelsController < ApplicationController

  protect_from_forgery


  def index
    @hotels = Hotel.all
  end

  def new
    @hotel = Hotel.new
    @user = current_user
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.valid?(:create) && @hotel.save
      flash[:notice] = "ルームを新規登録しました"
      redirect_to:hotels
    else
      @user = current_user
      flash[:alert] = "登録できませんでした。"
      render :new
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
    @booking = Booking.new
  end

  def edit
  end

  def update
  end

  def destroy
    @hotel = Hotel.find(params[:id])
    @hotel.destroy
    flash[:notice] = "ルームを削除しました"
    redirect_to :hotels
  end

  def booking_confirm
    @booking = Booking.new(booking_confirm_params)
    @hotel = Hotel.find(@booking.hotel_id)
    if @booking.valid?(:booking_confirm) 
      @booking.using_days = @booking.check_out - @booking.check_in
      @booking.total_price = @hotel.hotel_price * @booking.client_num * @booking.using_days
    else
      flash[:alert] = "まだ予約は完了しておりません。"
      render :show
    end
  end

  def booking_complete
    @booking = Booking.new(booking_params)
    if @booking.valid?(:booking_complete) && @booking.save
      flash[:notice] = "ルームを予約しました"
      redirect_to:bookings
    else
      @hotel = Hotel.find(@booking.hotel_id)
      flash[:alert] = "予約できませんでした。"
      render :new
    end
  end

  private

  def hotel_params
    params.require(:hotel).permit(:hotel_name, :hotel_introduction, :hotel_price, :hotel_address, :user_id)
  end

	def booking_confirm_params
    params.require(:booking).permit(:check_in, :check_out, :hotel_id, :client_num)
	end

  def booking_params
    params.require(:booking).permit(:total_price, :check_in, :check_out, :hotel_id, :client_num, :using_days)
  end

end
