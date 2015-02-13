module Noggin
  module Node
    class Output < Noggin::Node::Base

      attr_accessor :expected

      def error_derivative
        output - expected
      end

      def derivative_chain
        output_derivative * error_derivative
      end

    end
  end
end