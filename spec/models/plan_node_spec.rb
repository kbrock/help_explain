require 'spec_helper'


describe PlanNode do
  subject {
    PlanNode.new(complex_plan[0]["Plan"])
  }

  context "#params" do
    it "should return name" do
      expect(subject.name).to eq("Limit")
    end

    it "should return plan_startup_cost" do
      expect(subject.plan_startup_cost).to eq(23.04)
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


    it "should return actual_startup_time" do
      expect(subject.actual_startup_time).to eq(0.116)
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
      expect(subject.children.first.name).to eq("Sort")
    end
  end
end
