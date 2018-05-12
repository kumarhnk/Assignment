class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @room_types = RoomType.all
  end
end
