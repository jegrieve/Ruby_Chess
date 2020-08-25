require "./lib/board.rb"
require "./lib/player.rb"

class Game
    attr_accessor :board, :players, :game_board
    def initialize(player1, player2)
        @game_board = Board.new(player1, player2)
        @players = [player1,player2] #these will be player instances
        run
    end

    def run
        display_board
        current_player = self.players.first
        puts "#{current_player.player}'s turn'"
        piece_input = current_player.get_input_piece
        while !valid_piece?(piece_input, current_player)
            puts "Piece not valid, please choose a valid piece"
            piece_input = current_player.get_input_piece
        end
        piece = selected_piece(piece_input)
        move_input = current_player.get_input_move(piece)
        
        while !valid_move?(piece_input, move_input, piece) || !valid_game_move(piece_input, move_input, piece)
            puts "Move not valid, please choose a valid move"
            move_input = current_player.get_input_move(piece)
        end
        place_piece(move_input, piece, piece_input)
        self.players.reverse!
        display_board
    end

    def display_board
        self.game_board.display
    end

    def valid_piece?(piece_pos, current_player)
        y, x = piece_pos
        return false if self.game_board.board[y][x] == " " || self.game_board.board[y][x].player != current_player.player
        true
    end

    def selected_piece(piece_pos)
        y, x = piece_pos
        self.game_board.board[y][x]
    end

    def valid_move?(piece_input, move_input, piece)
        return true if self.game_board.valid_board_moves.include?(move_input) && piece.possible_moves(piece_input).include?(move_input)
        false
    end

    def place_piece(move_input, piece, piece_input)
        y, x = move_input
        j, i = piece_input
        self.game_board.board[y][x] = piece
        self.game_board.board[j][i] = " "
    end

    #--------------------------------------------------------------

    def valid_game_move(piece_input, move_input, piece) #Checks if move is actually valid
        case piece.piece_type
        when "Rook"
           return true if rook_valid_moves(piece_input, move_input, piece)
           false  
        when "Pawn"
           return true if pawn_valid_moves(piece_input, move_input, piece)
           false  
        when "Knight"
           return true if knight_valid_moves(piece_input, move_input, piece)
           false  
        when "Bishop"
           return true if bishop_valid_moves(piece_input, move_input, piece)
           false  
        when "Queen"
           return true if queen_valid_moves(piece_input, move_input, piece)
           false  
        when "King"
           return true if king_valid_moves(piece_input, move_input, piece)
           false  
        end
    end

    def rook_valid_moves(piece_input, move_input, piece)
        y, x = piece_input #current location input
        i, j = move_input #move to this location input
        return false if y == i && x == j

        if self.game_board.board[i][j] != " "
            return false if self.game_board.board[i][j].player == piece.player
        end

        if y == i #horizontal case
            move_array = self.game_board.board[y]
        
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
        elsif x == j #vertical case
            move_array = self.game_board.board.transpose[x]
        
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

    # def pawn_valid_moves(piece_input, move_input, piece)

    # end

    def knight_valid_moves(piece_input, move_input, piece)
        y, x = piece_input #current location input
        i, j = move_input #move to this location input

        return false if y == i && x == j

        if self.game_board.board[i][j] != " "
            return false if self.game_board.board[i][j].player == piece.player
        end

        return true
    end

    def bishop_valid_moves(piece_input, move_input, piece)
        y, x = piece_input #current location input
        i, j = move_input #move to this location input

        return false if y == i && x == j

        if self.game_board.board[i][j] != " "
            return false if self.game_board.board[i][j].player == piece.player
        end

        if y < i  #UP
            #while
            y += 1
            if x < j #RIGHT
                x += 1
                while x < j
                    return false if self.game_board.board[y][x] != " " 
                    x += 1
                    y += 1
                end

            else # LEFT
                x -= 1
                while x > j
                    return false if self.game_board.board[y][x] != " " 
                    x -= 1
                    y += 1
                end
            end
            #end
        else #DOWN
            y -= 1
            if x < j #RIGHT
                x += 1

                while x < j
                    return false if self.game_board.board[y][x] != " " 
                    x += 1
                    y -= 1
                end
            else #LEFT
                x -= 1

                while x > j
                    return false if self.game_board.board[y][x] != " " 
                    x -= 1
                    y -= 1
                end 
            end
            return true
        end



    end

    # def queen_valid_moves(piece_input, move_input, piece)

    # end

    def king_valid_moves(piece_input, move_input, piece) #will have to prevent being placed in check positions
        y, x = piece_input #current location input
        i, j = move_input #move to this location input

        return false if y == i && x == j
        #return false if check?(piece_input, move_input, piece)

        if self.game_board.board[i][j] != " "
            return false if self.game_board.board[i][j].player == piece.player
        end

        return true
    end







end

#Todo:
#1. Get valid moves for each piece, so we can only moves pieces that aren't "blocked" by other pieces
#2. Implement check and checkmate feature (for win), after every move, look at the possible moves for each move of the oposing pieces -
# look at the moves (or look at the valid moves rather) and see if any oposing pieces can reach the position of the king -
#if it can reach position then that is check (also make sure you can't put yourself in check)
#if the king has no positions that aren't in check then it is a loss.

Game.new(Player.new("james"),Player.new("adam"))


# if __FILE__ == $PROGRAM_NAME
#     puts "Welcome to Chess!"
#     puts "Player 1 enter name:"
#     player_1 = gets.chomp
#     puts "Player 2 enter name:"
#     player_2 = gets.chomp
#     Game.new(Player.new(player_1), Player.new(player2))
# end
