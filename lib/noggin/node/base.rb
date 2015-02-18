module Noggin
  module Node
    class Base

      attr_reader :origins
      attr_reader :dests
      attr_accessor :derivative

      def initialize
        @origins = []
        @dests = []
      end

      def input
        origins.inject(0) { |sum, edge | sum += edge.value }
      end

      def output
        1 / ( 1 + Math.exp(-1 * input) )
      end

      def output_derivative
        output * (1 - output)
      end

      def derivative_chain
        derivative = output_derivative * dests.inject(0) { |sum, edge| sum += edge.derivative_chain }
      end

    end
  end
end