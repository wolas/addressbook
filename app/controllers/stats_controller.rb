class StatsController < ApplicationController
  
  # GET /stats
  def index
    @stats = Stat.find(:all)
    @stats = @stats.group_by {|stat| stat.time.to_date }
    @stats = @stats.map {|date, stats| [date.strftime("%d-%m"), stats.count]}
  end
end
