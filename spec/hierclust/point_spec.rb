require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

module Hierclust
  describe Point do
    before do
      @p = Point.new(1, 1)
      @p2 = Point.new(2, 1)
    end

    it "should have points that is an array of only self" do
      @p.points.should == [@p]
    end

    it "should calculate distance to other" do
      @p.distance_to(@p2).should == 1.0
    end

    it "should have zero radius" do
      @p.radius.should == 0.0
    end
  end
end