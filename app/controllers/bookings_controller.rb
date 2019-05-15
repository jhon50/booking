class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_available_seats, only: [:new]
  before_action :check_disabled_dates, only: [:new]

  def index
    @bookings = Bookingg.where(user: current_user)
  end

  def new
    @booking = Bookingg.new
  end

  def create
    @booking = Bookingg.new(booking_params.merge(user: current_user))

    if @booking.save
      redirect_to bookings_path
    else
      render 'new'
    end
  end

  def show
    @booking = Bookingg.find(params[:id])
  end

  def destroy
    Bookingg.find(params[:id]).destroy!

    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:bookingg).permit(:desk, :to, :from)
  end

  def set_available_seats
    available_seats = []
    available_seats << (1..10).map {|x| 'A' + x.to_s}
    available_seats << (1..10).map {|x| 'B' + x.to_s}
    available_seats << (1..10).map {|x| 'C' + x.to_s}
    @available_seats = available_seats.flatten
  end

  def check_disabled_dates
    @disabled_dates = Bookingg.all.map{ |x| [x.to,x.from] }.flatten
  end
end