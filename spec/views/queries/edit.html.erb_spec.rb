require 'spec_helper'

describe "queries/edit" do
  before(:each) do
    @query = assign(:query, stub_model(Query,
      :name => "MyString",
      :comment => "MyString",
      :sql => "MyString",
      :plan => "MyString"
    ))
  end

  it "renders the edit query form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", query_path(@query), "post" do
      assert_select "input#query_name[name=?]", "query[name]"
      assert_select "textarea#query_sql[name=?]", "query[sql]"
      assert_select "textarea#query_plan[name=?]", "query[plan]"
    end
  end
end
