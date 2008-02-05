require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

module Hierclust
  describe Cluster, " with no points" do
    before do
      @c = Cluster.new([])
    end

    it "should have nil x-coordinate" do
      @c.x.should be_nil
    end

    it "should have nil y-coordinate" do
      @c.y.should be_nil
    end
  end

  describe Cluster, " with one point" do
    before do
      @x = 123
      @y = 234
      @p = Point.new(@x, @y)
      @c = Cluster.new([@p])
    end

    it "should have the same x-coordinate as the point" do
      @c.x.should == @p.x
    end

    it "should have the same y-coordinate as the point" do
      @c.y.should == @p.y
    end
  end

  describe Cluster, " with two points" do
    before do
      @x_1, @x_2 = 5, 15
      @y_1, @y_2 = 4, 8
      @p_1 = Point.new(@x_1, @y_1)
      @p_2 = Point.new(@x_2, @y_2)
      @c = Cluster.new([@p_1, @p_2])
      @points = @c.points
    end

    it "should have x-coordinate at average of point's x-coordinates" do
      @c.x.should == 10
    end

    it "should have y-coordinate at average of point's y-coordinates" do
      @c.y.should == 6
    end

    it "should have two points" do
      @points.size.should == 2
    end

    it "should include both points" do
      @points.should include(@p_1, @p_2)
    end
  end
end