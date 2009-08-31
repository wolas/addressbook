require File.dirname(__FILE__) + '/../../spec_helper'

describe "/stats/new.haml" do
  before do
    @stat = mock_model(Stat)
    @stat.stub!(:new_record?).and_return(true)
    @stat.stub!(:time).and_return(Time.now)
    assigns[:stat] = @stat
  end

  it "should render new form" do
    render "/stats/new.haml"
    
    response.should have_tag("form[action=?][method=post]", stats_path) do
    end
  end
end
