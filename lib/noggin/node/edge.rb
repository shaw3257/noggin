module Noggin
  module Node
    class Edge

      attr_accessor :origin
      attr_accessor :dest
      attr_accessor :weight
      attr_accessor :previous_weight
      attr_accessor :derivative
      attr_accessor :momentum

      def initialize origin: origin, dest: dest, weight: rand(0.20...0.80), momentum: 0.1
        @origin = origin
        @dest = dest
        @weight = weight
        @momentum = momentum
        @previous_weight = 0
      end

      def input
        origin.output
      end

      def value
        origin.output * weight
      end

      def derivative_chain
        derivative_chain = dest.derivative_chain
        @derivative = input * derivative_chain
        weight * derivative_chain
      end

      def pretty_print
        "w: #{weight.round(6)}, d: #{derivative.round(6)}"
      end

    end
  end
end