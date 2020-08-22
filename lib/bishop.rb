class Bishop
    attr_accessor :value
    def initialize(player, value)
        @value = value
        @player = player
    end

    def possible_moves(pos) 
        y, x = pos
        diagonal_left(pos).each {|move| moves << move}
        diagonal_right(pos).each {|move| moves << move}
        moves = []
    end

    def diagonal_left(pos)
        y, x = pos
        moves = []
        i = 0
        while i < 7
            moves << [y - i, x - i]
            moves << [y + i, x - i]
            i += 1
        end
        moves        
    end

    def diagonal_right(pos)
        y, x = pos
        moves = []
        i = 0
        while i < 7
            moves << [y - i, x + i]
            moves << [y + i, x + i]
            i += 1
        end
        moves    
    end
end

a = Bishop.new("a","b")
p a.diagonal_left([3,3])