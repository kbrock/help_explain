require 'spec_helper'

describe "queries/new" do
  before(:each) do
    assign(:query, stub_model(Query,
      :name => "MyString",
      :comment => "MyString",
      :sql => "MyString",
      :plan => "MyString"
    ).as_new_record)
  end

  it "renders new query form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", queries_path, "post" do
      assert_select "input#query_name[name=?]", "query[name]"
      assert_select "textarea#query_sql[name=?]", "query[sql]"
      assert_select "textarea#query_plan[name=?]", "query[plan]"
    end
  end
end
