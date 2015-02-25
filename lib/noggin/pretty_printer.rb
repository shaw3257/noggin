module Noggin
  class PrettyPrinter
    class << self
      def print_network network
        print "\n"
        grid = []
        network.layers.each do |layer|
          grid << col = []
          layer.neurons.each do |node|
            col << pretty_print_node(node)
          end
          col.flatten!
        end
        grid[0].zip(*grid[1..-1]).each do |row|
          row.each_with_index do |cell, col_i|
            max_length = grid[col_i].max_by{|s| s.size }.size
            if cell
              room = max_length - cell.length
              print cell
              print " " * room
              print "      "
            end
          end
          print "\n"
        end
      end

      def pretty_print_node node
        out = []
        out << " ------"
        out << "derivative: #{node.derivative}"
        out << "expected: #{node.expected}"
        out << "forward_input: #{node.forward_input}"
        out << "forward_output: #{node.forward_output}"
        out << "forward_error_output: #{node.forward_error_output}"
        out << "backward_input: #{node.backward_input}"
        out << "backward_output: #{node.backward_output}"
        out << "backward_error_output: #{node.backward_error_output}"
        node.dests.each do |edge|
          out << "|      | -EDGE--(#{pretty_print_edge(edge)}) "
        end
        out << " ------"
        out
      end

      def pretty_print_edge edge
        "w: #{edge.weight.round(6)}, d: #{edge.derivative.round(6)}"
      end
    end
  end
end

    