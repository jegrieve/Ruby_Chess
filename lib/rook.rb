class Rook
    attr_accessor :value
    def initialize(player, value)
        @value = value
        @piece = "Rook"
        @player = player
    end

    def possible_moves(pos) 
        moves = []
        pos_x = horizontal_moves(pos)
        pos_y = vertical_moves(pos)
        pos_x.each {|pos| moves << pos}
        pos_y.each {|pos| moves << pos}
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
end
