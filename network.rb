class Network

  attr_accessor :input_nodes
  attr_accessor :output_node

  def initialize size
    @input_nodes = Array.new(size){InputNode.new}
    @output_node = Node.new
    @input_nodes.each { |input_node| output_node << input_node }
  end

  def run input
    
    input_nodes.each_with_index do | node, i | 
      node.value = input[i] || 0
    end

    output_node.value

  end

end

class Node

  attr_reader :origins

  def initialize
    @origins = []  
  end

  def << node
    origins << Edge.new(origin: node )
  end

  def value
    origins.inject(0) do |sum, edge|
      sum += edge.weight * edge.origin.value
    end
  end

  def activiation input
    1 / ( 1 + Math.exp(input) )
  end

end

class InputNode

  attr_accessor :value

  def initialize value=nil
    @value = value
  end

end

class Edge

  attr_accessor :weight
  attr_accessor :origin

  def initialize origin: Node.new 
    @weight = Random.rand(100)
    @origin = origin
  end

end