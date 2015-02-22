module Noggin
  module Node
    class Base

      attr_reader :origins
      attr_reader :dests
      attr_accessor :derivative
      attr_accessor :cached_input
      attr_accessor :cached_output

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

      def pretty_print
        out = []
        out << " ------"
        dests.each do |edge|
          out << "|      | -EDGE--(#{edge.pretty_print}) "
        end
        out << " ------"
        out
      end

    end
  end
end