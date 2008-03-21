#!/usr/bin/env ruby

begin
  $LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
  require 'hierclust'
rescue LoadError
  require 'rubygems'
  require 'hierclust'
end

points = (1..20).map { Hierclust::Point.new(rand(800), rand(600)) }
clusterer = Hierclust::Clusterer.new(points)

print %Q{<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
  "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="800" height="600" version="1.1"
     xmlns="http://www.w3.org/2000/svg">
}

def plot(cluster)
  if cluster.kind_of? Hierclust::Cluster
    print %Q{
      <circle cx="#{cluster.x}" cy="#{cluster.y}" r="#{cluster.radius}"
              fill="none" stroke="black" stroke-width="#{cluster.items}"/>
    }
    cluster.items.each {|item| plot(item)}
  else
    print %Q{
      <circle cx="#{cluster.x}" cy="#{cluster.y}" r="2"
              fill="red" stroke="none"/>
    }
  end
end

clusterer.clusters.each {|cluster| plot cluster}

print %Q{
  <rect x="1" y="1" width="798" height="598"
        fill="none" stroke="grey" stroke-width="2" />
</svg>
}