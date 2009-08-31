require File.dirname(__FILE__) + '/../../spec_helper'

describe "/stat/edit.haml" do
  before do
    @stat = mock_model(Stat)
    @stat.stub!(:time).and_return(Time.now)
    assigns[:stat] = @stat
  end

  it "should render edit form" do
    render "/stats/edit.haml"
    
    response.should have_tag("form[action=#{stat_path(@stat)}][method=post]") do
    end
  end
end
