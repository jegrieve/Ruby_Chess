class Knight
    attr_accessor :value
    def initialize(player, value)
        @value = value
        @piece = "Knight"
        @player = player
    end

    def possible_moves(pos)
        knight_moves = [[1,2],[-1,2],[-1,-2],[1,-2],[2,-1],[2,1],[-2,-1],[-2,1]]
        moves = []
        y, x = pos

        knight_moves.each do |move|
            j, i = move
            moves << [j + y, i + x]
        end
        moves
    end

end
