class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :user, indexx: true
      t.belongs_to :room, index: true
      t.belongs_to :status, index: true
      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end
  end
end
