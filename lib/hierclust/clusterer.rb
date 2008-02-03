module Hierclust
  # Clusters a set of Points using Hierarchical Clustering, stopping either
  # when the hierarchy is complete or the clusters are separated by a given
  # minimum distance.
  class Clusterer
    # The Distances for the items being clustered
    attr_reader :distances

    # Create a new Clusterer for the given data.
    # 
    # Specify +separation+ to stop the clustering process once all the
    # items are at least +separation+ units apart.
    def initialize(data, separation = nil)
      @data = data.dup
      @separation = separation
      @distances = Distances.new(@data)
    end

    # Calculates and returns the set of clusters.
    def clusters
      return @data if @separation && @distances.separation > @separation
      while @data.length > 1
        @distances = Distances.new(@data)
        return @data if @separation && @distances.separation > @separation
        @data = find_cluster
      end
      @data
    end

    private
    
    def find_cluster
      case @data.length
      when 0
        []
      when 1
        [Cluster.new([@data[0]])]
      when 2
        [Cluster.new([@data[0], @data[1]])]
      else
        nearest = @distances.nearest
        outliers = @distances.outliers
        [Cluster.new(nearest), *outliers]
      end
    end
  end
end