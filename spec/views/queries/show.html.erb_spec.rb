require 'spec_helper'

describe "queries/show" do
  before(:each) do
    @query = assign(:query, Query.new(
      :id => 1,
      :name => "Name",
      :comment => "Comment",
      :sql => "select 1",
      :plan => select_plan_txt
    ).tap {|q| q.valid? })
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    #TODO: match plan text here
    #expect(rendered).to match(//)
  end
end
