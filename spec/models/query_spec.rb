require 'spec_helper'

describe Query do
  context "#clean_sql" do
    it "should leave object without explain alone" do
      expect(clean_sql('select a from table x')).to eq('select a from table x')
    end

    it "should remove standard explain" do
      expect(clean_sql('explain analyze verbose select a from table x')).to eq('select a from table x')
    end

    it "should leave object without explain alone" do
      expect(clean_sql('explain (analyze on, verbose on, format json) select a from table x')).to eq('select a from table x')
    end
  end

  context "#clean_plan" do
    it "should remove empty lines and spaces" do
      expect(clean_plan("   +\n  text  +\n  ")).to eq ("text\n")
    end

    it "should remove QUERY PLAN ---" do
      expect(clean_plan("\n  QUERY PLAN  \n---------\n  text  +\n  ")).to eq ("text\n")
    end

    it "should remove sql prompts" do
      expect(clean_plan("
        vmdb_development=# select something great
        vmdb_development(= select the rest;
          text  +\n  ")).to eq ("text\n")
    end

    it "should remove rows entry at the end" do
      expect(clean_plan("
          text  +\n (3 rows)  ")).to eq ("text\n")
    end
  end

  protected
  def clean_sql(str)
    Query.new(sql: str).tap{|q| q.send(:clean_sql) }.sql
  end

  def clean_plan(str)
    Query.new(plan: str).tap{|q| q.send(:clean_plan) }.plan
  end
end
