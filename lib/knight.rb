class Knight
    attr_accessor :value, :player, :piece_type
    def initialize(player, value, type)
        @value = value
        @player = player
        @piece_type = type
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

    def knight_valid_moves(piece_pos, piece_move_pos, board)
        y, x = piece_pos 
        i, j = piece_move_pos 

        return false if y == i && x == j

        if board[i][j] != " "
            return false if board[i][j].player == self.player
        end

        return true
    end
end
