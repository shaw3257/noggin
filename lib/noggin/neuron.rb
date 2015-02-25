module Noggin
  class Neuron

    attr_accessor :origins, :dests, :derivative, :expected, :forward_input, :forward_output, :forward_error_output,
                  :backward_input, :backward_output, :backward_error_output
    
    def initialize
      @origins = []
      @dests = []
    end

    def forward_activate!
      @forward_output = 1 / ( 1 + Math.exp(-1 * forward_input) )
      dests.each do |edge|
        edge.forward_input = @forward_output
        edge.forward_activate!
      end
      forward_activate_error! unless @expected.nil?
    end

    def backward_activate!
      @backward_output = @forward_output * ( 1 - @forward_output ) * @backward_input
      origins.each do |edge|
        edge.backward_input = @backward_output
        edge.backward_activate!
      end
    end

    def forward_activate_error!
      @forward_error_output = 0.5 * (@expected - @forward_output)**2
    end

    def backward_activate_error!
      @backward_error_output = @forward_output - @expected
      @backward_input = @backward_error_output
    end

    class << self
      def connect_neurons origin, dest, momentum
        edge = Noggin::Edge.new origin: origin, dest: dest, momentum: momentum
        origin.dests << edge
        dest.origins << edge
      end
    end
      
  end
end