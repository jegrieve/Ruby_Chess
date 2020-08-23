class Queen
    attr_accessor :value, :player
    def initialize(player, value)
        @value = value
        @player = player
    end

    def possible_moves(pos) 
        moves = []
        horizontal_moves(pos).each {|pos| moves << pos}
        vertical_moves(pos).each {|pos| moves << pos}
        diagonal_left(pos).each {|move| moves << move}
        diagonal_right(pos).each {|move| moves << move}
        moves
    end

    def horizontal_moves(pos)
        moves = []
        valid_moves = (0..7).to_a
        y, x = pos
        x = 0
        while x < 8
            move = [y, x]
            moves << move
            x += 1
        end
        moves
    end

    def vertical_moves(pos)
        moves = []
        valid_moves = (0..7).to_a
        y, x = pos
        y = 0
        while y < 8
            move = [y, x]
            moves << move
            y += 1
        end
        moves
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
