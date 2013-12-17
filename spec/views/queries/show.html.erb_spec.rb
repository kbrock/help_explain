require 'spec_helper'

describe "queries/show" do
  before(:each) do
    @query = assign(:query, stub_model(Query,
      :name => "Name",
      :comment => "Comment",
      :sql => "Sql",
      :plan => "Plan"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Comment/)
    expect(rendered).to match(/Sql/)
    expect(rendered).to match(/Plan/)
  end
end
