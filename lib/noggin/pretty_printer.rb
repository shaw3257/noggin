module Noggin
  class PrettyPrinter
    def self.print_network layers
      print "\n"
      grid = []
      layers.each do |layer|
        grid << col = []
        layer.each do |node|
          col << node.pretty_print
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
  end
end