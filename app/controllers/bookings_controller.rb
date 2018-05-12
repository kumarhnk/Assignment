class BookingsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    start_date = params[:start_date]
    end_date = params[:end_date]
    room_type = params[:room_type]
    if start_date == ''
      start_date = Date.today
    else
      start_date = Date.parse(start_date)
    end
    if end_date == ''
      end_date = start_date + 1.day
    else
      end_date = Date.parse(end_date)    
    end
    @room_types = RoomType.all
    rooms = Room.all
    if room_type != ''
      rooms = rooms.rewhere(room_type_id: room_type)
    end
    room_ids = rooms.pluck(:id)
    occupied_count = Booking.where('start_date <= ? and end_date >= ?', start_date, end_date).rewhere(status_id: 1, room_id: room_ids)
    if rooms.count > occupied_count.count
      @rooms  = rooms.where.not(id: occupied_count.pluck(:room_id))
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      @room_type = params[:room_type]
    else
      @rooms = []
    end

    respond_to do |format|
      if @rooms.count > 0
        @booking = Booking.create(user: current_user, start_date: start_date, end_date:end_date, room: @rooms.first, status_id: 1)
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

end
