require 'spec_helper'

describe "queries/index" do
  before(:each) do
    assign(:queries, [
      stub_model(Query,
        :name => "Name",
        :comment => "Comment",
        :sql => "Sql",
        :plan => select_plan_txt,
        :created_at => Time.now
      ),
      stub_model(Query,
        :name => "Name",
        :comment => "Comment",
        :sql => "Sql",
        :plan => select_plan_txt,
        :created_at => Time.now
      )
    ])
  end

  it "renders a list of queries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
