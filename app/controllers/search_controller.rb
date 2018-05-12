class SearchController < ApplicationController
  def check_availbility
    start_date = params[:start_date]
    end_date = params[:end_date]
    room_type = params[:room_type]
    # binding.pry
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
      @rooms  = rooms.where.not(id: occupied_count.pluck(:room_id)).group(:room_type_id)
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      @room_type = params[:room_type]
    else
      @rooms = []
    end

    respond_to do |format|
      format.html 
      format.json { render json: @rooms.map{|room| room.transform}}
     end
  end
end
