class StatsController < ApplicationController
  
  # GET /stats
  def index
    @stats = Stat.all
    @stats = make_stats @stats
  end
  
  def change_dates
    dates = ((params[:range].to_i.days.ago.to_date)..Date.today).to_a
    @stats = Stat.all.select{|stat| dates.include? stat.time.to_date }
    @stats = make_stats @stats
    render :partial => 'graph', :locals => {:stats => @stats}
  end
  
  protected
  
  def make_stats stats
    @stats = @stats.group_by {|stat| stat.time.to_date }.sort
    @stats = @stats.map {|date, stats| [date.strftime("%d %b %Y"), stats.count]}
  end
end
