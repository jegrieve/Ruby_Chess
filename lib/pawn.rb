class Pawn
    attr_accessor :value, :count, :player, :piece_type
    def initialize(player, value, type)
        @value = value
        @player = player
        @count = 0
        @piece_type = type
    end

    def possible_moves(pos) 
        y, x = pos
        moves = []
        if self.count == 0 
            moves << [y - 1, x]
            moves << [y - 2, x]
            self.count += 1
        else
            moves << [y - 1, x]
            moves << [y - 1, x + 1]
            moves << [y - 1, x - 1]
        end
        moves
    end

    def pawn_valid_moves(piece_pos, piece_move_pos, board)
        y, x = piece_pos
        i, j = piece_move_pos 

        return false if y == i && x == j

        if board[i][j] != " "
            return false if board[i][j].player == self.player
        end

        if x == j 
            y += 1
            while y < i 
                return false if board[y][x] != " " 
                y += 1
            end
        else 
            if x < j 
                return true if board[i][j] != " " && board[i][j].player != self.player
            else 
                return true if board[i][j] != " " && board[i][j].player != self.player
            end
        end
        return true
    end

    #  def promotion(pos)
    #     y, x = pos
    #     if y == 0
    #         puts "Choose a new piece"
    #         piece = gets.chomp
    #     end
    #  end
end
