require 'spec_helper'

describe SqlText do
  context "#clean_sql" do
    it "should leave object without explain alone" do
      expect(SqlText.clean('select a from table x')).to eq('select a from table x')
    end

    it "should remove standard explain" do
      expect(SqlText.clean('explain analyze verbose select a from table x')).to eq('select a from table x')
    end

    it "should leave object without explain alone" do
      expect(SqlText.clean('explain (analyze on, verbose on, format json) select a from table x')).to eq('select a from table x')
    end

    it "should remove database name" do
      expect(SqlText.clean("vmdb_development=# select 1\n vmdb_development-# from dual where (\nvmdb_development(# 1=2);"))
        .to eq("select 1\nfrom dual where (\n1=2);")
    end
  end

  context "#simplify_filter" do
    it "should clean recheck cond" do
      expect(SqlText.simplify_filter("((((public.miq_queue.queue_name)::text = 'generic'::text) AND (public.miq_queue.role IS NULL) AND (public.miq_queue.priority <= 200)"))
        .to eq("(((queue_name = 'generic') AND (role IS NULL) AND (priority <= 200)")
    end
  end
end
