require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

module Hierclust
  describe Clusterer, " with no data" do
    before do
      @c = Clusterer.new([])
    end

    it "should return no clusters" do
      @c.clusters.should == []
    end
  end

  describe Clusterer, " with one point" do
    before do
      @x = 1
      @y = 2
      @p = Point.new(@x, @y)
      @c = Clusterer.new([@p])
    end

    it "should return the point" do
      @c.clusters.should == [@p]
    end
  end

  describe Clusterer, " with two points" do
    before do
      @x_1, @x_2 = 1, 5
      @y_1, @y_2 = 2, 8
      @p_1 = Point.new(@x_1, @y_1)
      @p_2 = Point.new(@x_2, @y_2)
      @c = Clusterer.new([@p_1, @p_2])
    end

    it "should return one cluster" do
      @c.clusters.size.should == 1
    end

    it "should have two points in the cluster" do
      @c.clusters.first.size.should == 2
    end

    it "should have the first point in the cluster" do
      @c.clusters.first.should include(@p_1)
    end

    it "should have the second point in the cluster" do
      @c.clusters.first.should include(@p_2)
    end
  end

  describe Clusterer, " with three points" do
    before do
      @x_1, @x_2, @x_3 = 1, 5, 2
      @y_1, @y_2, @y_3 = 2, 6, 3
      @p_1 = Point.new(@x_1, @y_1)
      @p_2 = Point.new(@x_2, @y_2)
      @p_3 = Point.new(@x_3, @y_3)
      @c = Clusterer.new([@p_1, @p_2, @p_3])
      @cluster = @c.clusters.first
      @clusters = @cluster.items.sort_by{|c|c.size}
    end

    it "should return one cluster" do
      @c.clusters.size.should == 1
    end

    it "containing two items" do
      @cluster.items.size.should == 2
    end

    it "should have one Cluster" do
      @clusters[1].class.should == Cluster
    end

    it "and one Point" do
      @clusters[0].class.should == Point
    end

    it "should have the first and third points in the bigger cluster" do
      @clusters[1].should include(@p_1, @p_3)
    end

    it "should have the second point in the smaller cluster" do
      @clusters[0].should == @p_2
    end
  end

  FOUR_P = [
    Point.new(0, 1),
    Point.new(1, 0),
    Point.new(3, 4),
    Point.new(4, 3),
  ]
  
  describe Clusterer, " with four points and no separation" do
    before do
      @c = Clusterer.new(FOUR_P)
    end

    it "should return one cluster" do
      @c.clusters.size.should == 1
    end
  end

  describe Clusterer, " with four points and separation 1" do
    before do
      @c = Clusterer.new(FOUR_P, 1)
    end

    it "should return all four individual points" do
      @c.clusters.size.should == 4
    end
  end

  describe Clusterer, " with four points and separation 2" do
    before do
      @c = Clusterer.new(FOUR_P, 2)
    end

    it "should return two clusters" do
      @c.clusters.size.should == 2
    end
  end

  EIGHT_P = [
    Point.new(0, 1),
    Point.new(1, 0),
    Point.new(3, 4),
    Point.new(4, 3),
    Point.new(7, 8),
    Point.new(8, 7),
    Point.new(8, 9),
    Point.new(9, 8),
  ]
  
  describe Clusterer, " with eight points and no separation" do
    before do
      @c = Clusterer.new(EIGHT_P)
    end

    it "should return one cluster when no minimum separation is given" do
      @c.clusters.size.should == 1
    end
  end

  describe Clusterer, " with eight points and separation 1" do
    before do
      @c = Clusterer.new(EIGHT_P, 1)
    end

    it "should return all eight individual points" do
      @c.clusters.size.should == 8
    end
  end

  describe Clusterer, " with eight points and separation 2" do
    before do
      @c = Clusterer.new(EIGHT_P, 2)
    end

    it "should return three clusters" do
      @c.clusters.size.should == 3
    end
  end
end