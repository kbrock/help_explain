require 'spec_helper'


describe PlanNode do
  subject {
    PlanNode.new(complex_plan[0]["Plan"])
  }

  context "#id" do
    it "should auto increment the id" do
      assert_not_nil id1 = PlanNode.new(complex_plan).id
      assert_not_nil id2 = PlanNode.new(complex_plan).id
      expect(id1).not_to eq(id2)
    end
  end

  context "#params" do
    it "should return name" do
      expect(subject.name).to match(/Limit$/)
    end

    it "should return plan_child_cost" do
      expect(subject.plan_child_cost).to eq(23.04)
    end

    it "should return plan_total_cost" do
      expect(subject.plan_total_cost).to eq(23.05)
    end

    it "should return plan_rows" do
      expect(subject.plan_rows).to eq(2)
    end

    it "should return plan_width" do
      expect(subject.plan_width).to eq(2082)
    end

    it "should return actual_child_time" do
      expect(subject.actual_child_time).to eq(0.116)
    end

    it "should return actual_total_time" do
      expect(subject.actual_total_time).to eq(0.118)
    end

    it "should return actual_rows" do
      expect(subject.actual_rows).to eq(7)
    end

    it "should return actual_loops" do
      expect(subject.actual_loops).to eq(1)
    end
  end

  context "#children" do
    it "should have children" do
      expect(subject.children.size).to eq(1)
      expect(subject.children.first.type).to eq("Sort")
      expect(subject.children.first.name).to eq("Quicksort Memory 28k") #"Sort"
      expect(subject).to be_children
    end
  end
end
