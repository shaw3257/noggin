module Noggin
  class Bias

    attr_accessor :dests, :forward_output

    def initialize
      @dests = []
      @forward_output = 1
    end

    def forward_activate!
      dests.each do |edge|
        edge.forward_input = @forward_output
        edge.forward_activate!
      end
    end

    def learn!
      dests.each(&:learn!)
    end

  end
end