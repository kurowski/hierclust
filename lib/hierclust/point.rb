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
    
    # Returns this distance from this Point to an +other+ Point.
    def distance_to(other)
      Math.sqrt((other.x - self.x) ** 2 + (other.y - self.y) ** 2)  
    end
    
    # Simplifies code by letting us treat Clusters and Points interchangeably
    def size #:nodoc:
      1
    end
    
    # Simplifies code by letting us treat Clusters and Points interchangeably
    def radius #:nodoc:
      0
    end
    
    # Simplifies code by letting us treat Clusters and Points interchangeably
    def points #:nodoc:
      [self]
    end
    
    # Returns a legible representation of this Point.
    def to_s
      "(#{x}, #{y})"
    end
    
    # Sorts points relative to each other on the x-axis.
    # 
    # Uses y-axis as a tie-breaker, so that sorting is stable even if
    # multiple points have the same x-coordinate.
    # 
    # Uses object_id as a final tie-breaker, so sorts are guaranteed to
    # be stable even when multiple points have the same coordinates.
    def <=>(other)
      cmp = self.x <=> other.x
      cmp = self.y <=> other.y if cmp == 0
      cmp = self.object_id <=> other.object_id if cmp == 0
      return cmp
    end
  end
end