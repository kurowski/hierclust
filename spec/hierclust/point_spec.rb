require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

module Hierclust
  describe Point do
    before do
      @p = Point.new(1, 1)
    end

    it "should have points that is an array of only self" do
      @p.points.should == [@p]
    end
  end
end