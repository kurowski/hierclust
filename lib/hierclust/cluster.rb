module Hierclust
  # A Cluster represents a collection of Points. A Cluster has it's own
  # coordinates that are the mean of the coordinates of it's points.
  # Because a Cluster has coordinates, it can act as a Point and therefore
  # be included in other Clusters.
  class Cluster < Point
    # An array of items in this cluster
    attr_accessor :items
    
    # Create a Cluster for the given set of +items+.
    def initialize(items)
      @items = items
    end
    
    # Returns the average x-coordinates of all items in this Cluster.
    def x
      return nil if size == 0
      points = self.points
      @x ||= points.inject(0.0) {|sum, p| sum + p.x} / points.size
    end

    # Returns the average y-coordinates of all items in this Cluster.
    def y
      return nil if size == 0
      points = self.points
      @y ||= points.inject(0.0) {|sum, p| sum + p.y} / points.size
    end
    
    # Add an +item+ to this Cluster.
    def <<(item)
      @x, @y = nil, nil # flush cached pseudo-attributes
      @items << item
    end
    
    # Returns the number of items in this Cluster.
    def size
      @items.size
    end
    
    # Returns the distance from the center of this Cluster to the edge.
    def radius
      return nil if @items.empty?
      return 0 if @items.size == 1
      return (@items[0].distance_to(@items[1]) + @items[0].radius + @items[1].radius) / 2.0
      raise "radius not implemented for clusters with more than two items"
    end
    
    # Returns a flat list of all the points contained in either this cluster
    # or any of the clusters it contains.
    def points
      @items.map {|item| item.points}.flatten
    end
    
    # Returns +true+ if this Cluster includes the given +item+, otherwise
    # returns +false+.
    def include?(item)
      @items.include? item
    end
    
    # Returns a legible representation of this Cluster and it's items.
    def to_s
      "[#{@items.join(', ')}]"
    end
  end
end