module Noggin
  module Node
    class Output < Noggin::Node::Base

      attr_accessor :expected

      def error
        0.5 * (expected - output)**2
      end

      def error_derivative
        output - expected
      end

      def derivative_chain
        output_derivative * error_derivative
      end

      def pretty_print
        out = []
        out << " --------------"
        out << "| ed: #{error_derivative.round(6)}"
        out << "| d: #{derivative_chain.round(6)}"
        out << "| e: #{error.round(6)}"
        out << "| o: #{output.round(6)}"
        out << " --------------"
        out
      end
    end
  end
end