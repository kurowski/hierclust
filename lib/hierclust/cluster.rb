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
      @x ||= @items.inject(0) {|sum, p| sum + p.x} / size
    end

    # Returns the average y-coordinates of all items in this Cluster.
    def y
      return nil if size == 0
      @y ||= @items.inject(0) {|sum, p| sum + p.y} / size
    end
    
    # Returns the number of items in this Cluster.
    def size
      @items.size
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