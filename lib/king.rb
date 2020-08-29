class King
    attr_accessor :value, :player, :piece_type
    def initialize(player, value, type)
        @value = value
        @player = player
        @piece_type = type
    end

    def possible_moves(pos) 
        y, x = pos
        moves = []
        top_moves(pos).each {|move| moves << move}
        side_moves(pos).each {|move| moves << move}
        bot_moves(pos).each {|move| moves << move}
        moves
    end

    def top_moves(pos)
        y, x = pos
        moves = []
        moves << [y - 1, x]
        moves << [y - 1, x + 1]
        moves << [y - 1, x - 1]
        moves
    end

    def bot_moves(pos)
        y, x = pos
        moves = []
        moves << [y + 1, x]
        moves << [y + 1, x + 1]
        moves << [y + 1, x - 1]
        moves
    end

    def side_moves(pos)
        y, x = pos
        moves = []
        moves << [y, x + 1]
        moves << [y, x - 1]
        moves
    end

    def king_valid_moves(piece_pos, piece_move_pos, board)
        y, x = piece_pos 
        i, j = piece_move_pos 

        return false if y == i && x == j

        if board[i][j] != " "
            return false if board[i][j].player == self.player
        end

        return true
    end
end