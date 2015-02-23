module Noggin
  class Network

    attr_reader :input_nodes
    attr_reader :output_node
    attr_reader :layers
    attr_reader :options

    DEFAULTS = {
        learning_rate: 0.3,
        momentum: 5,
        max_training_laps: 2000,
        hidden_layer_size: 1,
        hidden_layer_node_size: 2,
        log: false
    }

    def initialize **opts
      @options = DEFAULTS.merge opts
      @ready = false
      @layers = []
    end

    def run input
      update_input_nodes input
      output_node.output
    end

    def train data_batch
      init_network(data_batch)unless @ready
      options[:max_training_laps].times do |i|
        data_batch.each do |batch|
          propagate_error! batch[:input], batch[:output]
          if options[:log] && i == options[:max_training_laps] - 1
            print "Last train for input: #{batch[:input]}, expected: #{batch[:output]}"
            pretty_print
          end
        end
      end
      return self
    end

    def propagate_error! input, expected
      update_input_nodes input
      output_node.expected = expected
      input_nodes.each { |node| node.derivative_chain }
      update_weights!
    end

    def update_weights!
      edges.each do |edge|
        delta_weight = options[:learning_rate] * edge.derivative
        edge.weight -= delta_weight + (edge.momentum * edge.previous_weight)
        edge.previous_weight = delta_weight
      end
    end

    def init_network data_batch
      @input_nodes = Array.new(data_batch.first[:input].size + 1){ Noggin::Node::Input.new }
      @layers << @input_nodes
      last_layer = @input_nodes
      options[:hidden_layer_size].times do |i|
        new_layer = Array.new(options[:hidden_layer_node_size]){ Noggin::Node::Base.new }
        bias_node = Noggin::Node::Input.new
        bias_node.output = 1
        new_layer << bias_node
        @layers << new_layer
        connect_layer last_layer, new_layer
        last_layer = new_layer
      end
      @output_node = Noggin::Node::Output.new
      @layers << [@output_node]
      last_layer.each { |node| connect_nodes(node, output_node) }
      @ready = true
    end

    def edges
      edges = []
      queue = [output_node]
      while queue.size != 0 do
        node = queue.pop
        node.origins.each do |edge|
          edges << edge
          queue << edge.origin
        end
      end
      edges
    end

    def connect_nodes origin, dest
      edge = Noggin::Node::Edge.new origin: origin, dest: dest, momentum: options[:momentum]
      origin.dests << edge
      dest.origins << edge
    end

    def connect_layer origins, dests
      origins.each do |origin|
        dests.each do |dest|
          connect_nodes origin, dest
        end
      end
    end

    def update_input_nodes input
      input_nodes.each_with_index do | node, i |
        if i == (input.size)
          node.output = 1
        else
          node.output = input[i]
        end
      end
    end

    def pretty_print
       Noggin::PrettyPrinter.print_network layers
    end

  end
end