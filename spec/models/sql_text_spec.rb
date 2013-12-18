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
  end
end
