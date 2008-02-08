module Hierclust
  # Represents the pair-wise distances between a set of items.
  class Distances
    attr_reader :nearest, :outliers, :separation

    # Create a new Distances for the given +items+
    def initialize(items)
      @items = items
      @separation = 0
      @nearest = []
      items = @items.dup
      while !items.empty?
        origin = items.shift
        items.each do |other|
          distance = origin.distance_to(other)
          if @separation == 0 or distance < @separation
            @separation = distance
            @nearest = [origin, other]
          end
        end
      end
      @outliers = @items - @nearest
    end
  end
end