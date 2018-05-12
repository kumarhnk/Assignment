class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  belongs_to :status


  def transform
    hash_map = {
      id: self.id,
      room: self.room.name,
      room_type: self.room.room_type.name,
      start_date: self.start_date,
      end_date: self.end_date
    }
  end
end
