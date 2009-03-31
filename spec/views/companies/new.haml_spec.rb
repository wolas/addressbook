require File.dirname(__FILE__) + '/../../spec_helper'

describe "/companies/new.haml" do
  before do
    @company = mock_model(Company)
    @company.stub!(:new_record?).and_return(true)
    @company.stub!(:name).and_return("MyString")
    @company.stub!(:city).and_return("MyString")
    @company.stub!(:street).and_return("MyString")
    assigns[:company] = @company
  end

  it "should render new form" do
    render "/companies/new.haml"
    
    response.should have_tag("form[action=?][method=post]", companies_path) do
      with_tag("input#company_name[name=?]", "company[name]")
      with_tag("input#company_city[name=?]", "company[city]")
      with_tag("input#company_street[name=?]", "company[street]")
    end
  end
end
