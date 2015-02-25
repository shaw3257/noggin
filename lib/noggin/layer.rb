module Noggin
  class Layer

    attr_accessor :origin_layer, :dest_layer, :neurons, :bias

    def initialize
      @neurons = []
    end

    def forward_activate!
      @bias.forward_activate!
      @neurons.each do |neuron|
        neuron.forward_input = neuron.origins.inject(0){ |sum, edge| sum += edge.forward_output }
        neuron.forward_activate!
      end
    end

    def backward_activate!
      @neurons.each do |neuron|
        neuron.backward_input = neuron.dests.inject(0){ |sum, edge| sum += edge.backward_output }
        neuron.backward_activate!
      end
    end

    def biased
      @bias = Bias.new if bias.nil?
    end

    class << self

      def connect_layers origin_layer, dest_layer, momentum
        dest_layer.biased
        dest_layer.neurons.each do |dest_neuron|
          Noggin::Neuron.connect_neurons dest_layer.bias, dest_neuron, momentum
          origin_layer.neurons.each do |origin_neuron|
            Noggin::Neuron.connect_neurons origin_neuron, dest_neuron, momentum
          end
        end
        origin_layer.dest_layer = dest_layer
        dest_layer.origin_layer = origin_layer
      end

    end

  end
end