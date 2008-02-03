module Hierclust
  # Represents the pair-wise distances between a set of items.
  class Distances
    # Create a new Distances for the given +items+
    def initialize(items)
      @items = items
      @distances = {}
    end

    # Returns the distance between items +a+ and +b+.
    def [](a, b)
      key = (a.object_id < b.object_id) ?
            "#{a.object_id},#{b.object_id}" :
            "#{b.object_id},#{a.object_id}"
      @distances[key] ||= Math.sqrt((a.x - b.x) ** 2 + (a.y - b.y) ** 2)  
    end

    # Returns the pair of items that are nearest to each other.
    def nearest
      @nearest ||= begin
        key = nearest_pair[0]
        a_id, b_id = key.split ','
        a = @items.select {|item| item.object_id.to_s == a_id}.first
        b = @items.select {|item| item.object_id.to_s == b_id}.first
        [a, b]
      end
    end
    
    # Returns all items except the pair that are nearest to each other.
    def outliers
      @outliers ||= begin
        @items - nearest
      end
    end
    
    # Returns the smallest distance between any pair of items.
    def separation
      @separation ||= @items.size < 2 ? 0 : nearest_pair[1]
    end

    private

    def nearest_pair
      prepopulate_cache
      @distances.to_a.sort{|a, b| a[1] <=> b[1]}.first
    end
    
    def prepopulate_cache
      items = @items.dup
      while !items.empty?
        origin = items.shift
        items.each {|item| self[origin, item]}
      end
    end
  end
end