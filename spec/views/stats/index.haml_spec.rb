require File.dirname(__FILE__) + '/../../spec_helper'

describe "/stats/index.haml" do
  before do
    stat_98 = mock_model(Stat)
    stat_98.should_receive(:time).and_return(Time.now)
    stat_99 = mock_model(Stat)
    stat_99.should_receive(:time).and_return(Time.now)

    assigns[:stats] = [stat_98, stat_99]
  end

  it "should render list of stats" do
    render "/stats/index.haml"
  end
end
