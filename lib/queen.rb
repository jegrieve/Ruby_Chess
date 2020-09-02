class Queen
    attr_accessor :value, :player, :piece_type
    def initialize(player, value, type)
        @value = value
        @player = player
        @piece_type = type
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

    def queen_valid_moves(piece_pos, piece_move_pos, board)
        return true if valid_horizontal_moves(piece_pos, piece_move_pos, board) || valid_diagonal_moves(piece_pos, piece_move_pos, board)
        false
    end

    def valid_horizontal_moves(piece_pos, piece_move_pos, board)
        y, x = piece_pos
        i, j = piece_move_pos
        return false if y == i && x == j

        if board[i][j] != " "
            return false if board[i][j].player == self.player
        end

        if y == i 
            move_array = board[y]
        
            if x < j    
                x += 1
                while x < j 
                    return false if move_array[x] != " "
                    x += 1
            end
            else
                    x -= 1
                while x > j 
                    return false if move_array[x] != " "
                    x -= 1
                end
            end
            return true
        elsif x == j 
            move_array = board.transpose[x]
        
            if y < i    
                y += 1
                while y < i 
                    return false if move_array[y] != " "
                    y += 1
            end
            else
                    y -= 1
                while y > i 
                    return false if move_array[y] != " "
                    y -= 1
                end
            end
            return true
        end
    end

    def valid_diagonal_moves(piece_pos, piece_move_pos, board)
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
