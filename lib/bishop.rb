class Bishop
    attr_accessor :value, :player, :piece_type
    def initialize(player, value, type)
        @value = value
        @player = player
        @piece_type = type
    end

    def possible_moves(pos) 
        y, x = pos
        moves = []
        diagonal_left(pos).each {|move| moves << move}
        diagonal_right(pos).each {|move| moves << move}
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

    def bishop_valid_moves(piece_pos, piece_move_pos, board)
        y, x = piece_pos #current location input
        i, j = piece_move_pos #move to this location input

        return false if y == i && x == j

        if board[i][j] != " "
            return false if board[i][j].player == self.player
        end

        if y < i  
            y += 1
            if x < j 
                x += 1
                while x < j
                    return false if board[y][x] != " " 
                    x += 1
                    y += 1
                end

            else
                x -= 1
                while x > j
                    return false if board[y][x] != " " 
                    x -= 1
                    y += 1
                end
            end
        else 
            y -= 1
            if x < j 
                x += 1

                while x < j
                    return false if board[y][x] != " " 
                    x += 1
                    y -= 1
                end
            else 
                x -= 1
                while x > j
                    return false if board[y][x] != " " 
                    x -= 1
                    y -= 1
                end 
            end
            return true
        end
    end
end
