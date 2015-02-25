module Noggin
  class Edge

    attr_accessor :origin, :dest, :weight, :derivative, :forward_input, :forward_output, :backward_input, :backward_output

    def initialize origin: origin, dest: dest, weight: rand(0.20...0.80), momentum: 1, learning_rate: 0.3
      @origin = origin
      @dest = dest
      @weight = weight
      @momentum = momentum
      @previous_derivative = 0
      @learning_rate = learning_rate
    end

    def forward_activate!
      @forward_output = @forward_input * weight
    end

    def backward_activate!
      @backward_output = dest.backward_output * weight
      @derivative = dest.backward_output * origin.forward_output
    end

    def learn!
      @weight -= @learning_rate * @derivative + (@previous_derivative * @momentum)
      @previous_derivative = @derivative
    end

  end
end

