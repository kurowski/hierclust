module Hierclust
  # A Point represents a single point in 2-dimensional space.
  class Point
    # x-coordinate
    attr_accessor :x

    # y-coordinate
    attr_accessor :y
    
    # Create a new Point with the given x- and y-coordinates.
    def initialize(x, y)
      @x = x
      @y = y
    end

    # Simplifies code by letting us treat Clusters and Points interchangeably
    def size #:nodoc:
      1
    end
    
    # Simplifies code by letting us treat Clusters and Points interchangeably
    def points #:nodoc:
      self
    end
    
    # Returns a legible representation of this Point.
    def to_s
      "(#{x}, #{y})"
    end
    
    # Sorts points relative to each other on the x-axis.
    def <=>(other)
      return self.x <=> other.x
    end
  end
end