require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

module Hierclust
  describe Distances, " with two points" do
    before do
      @x_1, @x_2 = 1, 5
      @y_1, @y_2 = 2, 8
      @p_1 = Point.new(@x_1, @y_1)
      @p_2 = Point.new(@x_2, @y_2)
      @d = Distances.new([@p_1, @p_2])
      @dist = Math.sqrt((@x_1 - @x_2) ** 2 + (@y_1 - @y_2) ** 2)
    end

    it "should have separation equal to distance between those points" do
      @d.separation.should == @dist
    end
  end

  describe Distances, " with three points" do
    before do
      @x_1, @x_2, @x_3 = 1, 5, 3
      @y_1, @y_2, @y_3 = 2, 8, 4
      @p_1 = Point.new(@x_1, @y_1)
      @p_2 = Point.new(@x_2, @y_2)
      @p_3 = Point.new(@x_3, @y_3)
      @d = Distances.new([@p_1, @p_2, @p_3])
      @dist_1_2 = Math.sqrt((@x_1 - @x_2) ** 2 + (@y_1 - @y_2) ** 2)
      @dist_2_3 = Math.sqrt((@x_2 - @x_3) ** 2 + (@y_2 - @y_3) ** 2)
      @dist_3_1 = Math.sqrt((@x_3 - @x_1) ** 2 + (@y_3 - @y_1) ** 2)
    end

    it "should tell us the nearest points" do
      @d.nearest.should include(@p_1, @p_3)
    end

    it "should tell us the outliers" do
      @d.outliers.should == [@p_2]
    end

    it "should have separation equal to distance between nearest points" do
      @d.separation.should == @dist_3_1
    end
  end
end