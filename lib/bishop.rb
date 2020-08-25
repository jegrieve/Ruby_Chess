class Bishop
    attr_accessor :value, :player, :piece_type
    def initialize(player, value, type)
        @value = value
        @player = player
        @piece_type = type
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
