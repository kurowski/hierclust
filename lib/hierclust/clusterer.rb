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
      @separation = separation
      @data = precluster(data)
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
    
    def precluster(points)
      if @separation.nil?
        # can't precluster w/ no min separation given
        return points.dup
      end
      if @separation == 0
        # if no separation is asked for, it's all one cluster
        return [Cluster.new(points)]
      end
      grid_size = @separation / 2.0
      grid_clusters = Hash.new
      points.each do |point|
        grid_x = (point.x / grid_size).floor
        grid_y = (point.y / grid_size).floor
        grid_clusters[grid_x] ||= Hash.new
        grid_clusters[grid_x][grid_y] ||= Cluster.new([])
        grid_clusters[grid_x][grid_y] << point
      end
      grid_clusters.values.map{|h| h.values}.flatten
    end
  end
end