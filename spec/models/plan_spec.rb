require 'spec_helper'

describe Plan do

  context "with complex json" do
    subject { Plan.new(complex_plan_txt) }

    it "should have a base node" do
      expect(subject.node).to be_children
    end
  end

  context "#clean" do
    it "should remove empty lines and spaces" do
      expect(Plan.clean("   +\n  text  +\n  ")).to eq ("text\n")
    end

    it "should remove QUERY PLAN ---" do
      expect(Plan.clean("\n  QUERY PLAN  \n---------\n  text  +\n  ")).to eq ("text\n")
    end

    it "should remove sql prompts" do
      expect(Plan.clean("
        vmdb_development=# select something great
        vmdb_development(= select the rest;
          text  +\n  ")).to eq ("text\n")
    end

    it "should remove rows entry at the end" do
      expect(Plan.clean("
          text  +\n (3 rows)  ")).to eq ("text\n")
    end
  end
end
