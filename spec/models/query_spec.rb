require 'spec_helper'

describe Query do
  context "parsable_json" do
    it "should say valid object if valid json" do
      expect(Query.new(name: "name", sql: "select 1", plan: select_plan_txt)).to be_valid
    end
  end
end
