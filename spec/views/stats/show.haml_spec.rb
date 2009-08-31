require File.dirname(__FILE__) + '/../../spec_helper'

describe "/stats/show.haml" do
  before do
    @stat = mock_model(Stat)
    @stat.stub!(:time).and_return(Time.now)

    assigns[:stat] = @stat
  end

  it "should render attributes in <p>" do
    render "/stats/show.haml"
  end
end

