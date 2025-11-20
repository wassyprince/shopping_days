class EventsController < ApplicationController
  def calendar
    @events = []
    @date = params[:month]&.to_date || Date.today
  end
end
