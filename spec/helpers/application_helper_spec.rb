require "spec_helper"

describe ApplicationHelper do
  describe "#icon_and_text" do
    before do
      #stub out localization
      allow(helper).to receive('t').and_return('new')
    end

    it "defaults icon to action name" do
      expect(helper.icon_and_text('new')).to match /icon-new/
    end

    it "allows override of icon name" do
      expect(helper.icon_and_text('new','plus')).to match /icon-plus.*new/i
    end

    it "returns html" do
      expect(helper.icon_and_text('new')).to match /^</
    end
  end
end

