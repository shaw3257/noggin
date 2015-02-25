module Noggin
  class Network

    attr_accessor :layers, :options, :forward_input, :forward_output
    
     DEFAULTS = {
      learning_rate: 0.3,
      momentum: 1,
      training_laps: 50000,
      hidden_layer_size: 1,
      hidden_layer_node_size: 2,
      min_training_error: 0.001
    }

    def initialize **opts
      @options = DEFAULTS.merge opts
      @layers = []
      @ready = false
    end

    def train data_set
      @forward_input = data_set
      setup_layers unless @ready
      error = Float::INFINITY
      laps = 0
      until laps >= options[:training_laps] || error < options[:min_training_error] do
        laps += 1
        error = 0
        data_set.each do |set|
          setup_input set[:input]
          setup_expected set[:expected]
          error += run_for_error set[:input]
          setup_backwards
          run_backwards
          update_weights
        end
      end
      { total_error: error, training_laps_needed: laps }
    end

    def run input
      setup_input input
      run_forwards input
      layers.last.neurons.first.forward_output
    end

    def run_for_error input
      run_forwards input
      layers.last.neurons.inject(0){ |sum, neuron| sum += neuron.forward_error_output }
    end

    def run_forwards input
      layers[1..-1].each(&:forward_activate!)
    end

    def run_backwards
      layers.reverse[1..-1].each(&:backward_activate!)
    end

    def update_weights
      layers.each do |layer|
        layer.bias.learn! if layer.bias
        layer.neurons.each do |neuron|
          neuron.dests.each(&:learn!)
        end
      end
    end

    def setup_layers
      setup_input_layer
      setup_hidden_layers
      setup_output_layer
      @ready = true
    end

    def setup_input_layer
      input_layer = Layer.new
      input_layer.neurons = Array.new(input_set_size){ Noggin::Neuron.new }
      layers << input_layer
    end

    def setup_hidden_layers
      options[:hidden_layer_size].times do |i|
        hidden_layer = Layer.new
        hidden_layer.neurons = Array.new(options[:hidden_layer_node_size]){ Noggin::Neuron.new }
        Noggin::Layer.connect_layers layers.last, hidden_layer, options[:momentum]
        layers << hidden_layer
      end
    end

    def setup_output_layer
      output_layer = Layer.new
      output_layer.neurons = [ Noggin::Neuron.new ]
      Noggin::Layer.connect_layers layers.last, output_layer, options[:momentum]
      layers << output_layer
    end

    def setup_input set
      layers.first.neurons.each_with_index do |neuron, i|
        neuron.forward_input = neuron.forward_output = set[i]
        neuron.dests.each do |edge|
          edge.forward_input = neuron.forward_output
          edge.forward_activate!
        end
      end
    end

    def setup_backwards
      layers.last.neurons.each do |output_neuron|
        output_neuron.backward_activate_error!
        output_neuron.backward_activate!
      end
    end

    def setup_expected expected
      layers.last.neurons.each { |neuron| neuron.expected = expected }
    end

    def input_set_size
      forward_input.first[:input].size
    end

    def pretty_print
      Noggin::PrettyPrinter.print_network self
    end

  end
end