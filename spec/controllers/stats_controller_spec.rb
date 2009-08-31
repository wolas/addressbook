require File.dirname(__FILE__) + '/../spec_helper'

describe StatsController, "#route_for" do

  it "should map { :controller => 'stats', :action => 'index' } to /stats" do
    route_for(:controller => "stats", :action => "index").should == "/stats"
  end
  
  it "should map { :controller => 'stats', :action => 'new' } to /stats/new" do
    route_for(:controller => "stats", :action => "new").should == "/stats/new"
  end
  
  it "should map { :controller => 'stats', :action => 'show', :id => 1 } to /stats/1" do
    route_for(:controller => "stats", :action => "show", :id => 1).should == "/stats/1"
  end
  
  it "should map { :controller => 'stats', :action => 'edit', :id => 1 } to /stats/1/edit" do
    route_for(:controller => "stats", :action => "edit", :id => 1).should == "/stats/1/edit"
  end
  
  it "should map { :controller => 'stats', :action => 'update', :id => 1} to /stats/1" do
    route_for(:controller => "stats", :action => "update", :id => 1).should == "/stats/1"
  end
  
  it "should map { :controller => 'stats', :action => 'destroy', :id => 1} to /stats/1" do
    route_for(:controller => "stats", :action => "destroy", :id => 1).should == "/stats/1"
  end
  
end

describe StatsController, "handling GET /stats" do

  before do
    @stat = mock_model(Stat)
    Stat.stub!(:find).and_return([@stat])
  end
  
  def do_get
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should render index template" do
    do_get
    response.should render_template('index')
  end
  
  it "should find all stats" do
    Stat.should_receive(:find).with(:all).and_return([@stat])
    do_get
  end
  
  it "should assign the found stats for the view" do
    do_get
    assigns[:stats].should == [@stat]
  end
end

describe StatsController, "handling GET /stats/1" do

  before do
    @stat = mock_model(Stat)
    Stat.stub!(:find).and_return(@stat)
  end
  
  def do_get
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render show template" do
    do_get
    response.should render_template('show')
  end
  
  it "should find the stat requested" do
    Stat.should_receive(:find).with("1").and_return(@stat)
    do_get
  end
  
  it "should assign the found stat for the view" do
    do_get
    assigns[:stat].should equal(@stat)
  end
end

describe StatsController, "handling GET /stats/new" do

  before do
    @stat = mock_model(Stat)
    Stat.stub!(:new).and_return(@stat)
  end
  
  def do_get
    get :new
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render new template" do
    do_get
    response.should render_template('new')
  end
  
  it "should create an new stat" do
    Stat.should_receive(:new).and_return(@stat)
    do_get
  end
  
  it "should not save the new stat" do
    @stat.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new stat for the view" do
    do_get
    assigns[:stat].should equal(@stat)
  end
end

describe StatsController, "handling GET /stats/1/edit" do

  before do
    @stat = mock_model(Stat)
    Stat.stub!(:find).and_return(@stat)
  end
  
  def do_get
    get :edit, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render edit template" do
    do_get
    response.should render_template('edit')
  end
  
  it "should find the stat requested" do
    Stat.should_receive(:find).and_return(@stat)
    do_get
  end
  
  it "should assign the found stat for the view" do
    do_get
    assigns[:stat].should equal(@stat)
  end
end

describe StatsController, "handling POST /stats" do

  before do
    request.env["HTTP_REFERER"] = "/stats/1"
    @stat = mock_model(Stat, :to_param => "1")
    Stat.stub!(:new).and_return(@stat)
  end
  
  def post_with_successful_save
    @stat.should_receive(:save).and_return(true)
    post :create, :stat => {}
  end
  
  def post_with_failed_save
    @stat.should_receive(:save).and_return(false)
    post :create, :stat => {}
  end
  
  it "should create a new stat" do
    Stat.should_receive(:new).with({}).and_return(@stat)
    post_with_successful_save
  end

  it "should redirect to the new stat on successful save" do
    post_with_successful_save
    response.should redirect_to(stat_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe StatsController, "handling PUT /stats/1" do

  before do
    @stat = mock_model(Stat, :to_param => "1")
    Stat.stub!(:find).and_return(@stat)
  end
  
  def put_with_successful_update
    @stat.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @stat.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the stat requested" do
    Stat.should_receive(:find).with("1").and_return(@stat)
    put_with_successful_update
  end

  it "should update the found stat" do
    put_with_successful_update
    assigns(:stat).should equal(@stat)
  end

  it "should assign the found stat for the view" do
    put_with_successful_update
    assigns(:stat).should equal(@stat)
  end

  it "should redirect to the stat on successful update" do
    put_with_successful_update
    response.should redirect_to(stat_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe StatsController, "handling DELETE /stat/1" do

  before do
    request.env["HTTP_REFERER"] = "/stats"
    @stat = mock_model(Stat, :destroy => true)
    Stat.stub!(:find).and_return(@stat)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found stat" do
    @stat.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the stats list" do
    do_delete
    response.should redirect_to(stats_url)
  end
end
