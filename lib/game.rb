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
        while !win?
            display_board
            current_player = self.players.first
            puts "#{current_player.player}'s turn'"
            #if check?(current_player.player)
            #have to move your own king
            #else
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
            #break if checkmate?(current_player.player)
            display_board
            winner(self.players.first.player) if win?
            self.players.reverse!
            rotate_board
            #end
        end
    end

    def win?(player)
        return true if checkmate?(player)
    end

    def move_check
        
    end

    def check?(player)
        self.game_board.board.each_with_index do |row,y|
            row.each_with_index do |piece,x|
                if piece != " " && piece.player != player
                     possible_moves = piece.possible_moves([y,x])
                     king_pos = king_pos(player)
                     #need to see if any of these moves can hit king
                     possible_checks = hit_king?(king_pos, possible_moves) #returns moves that hit king EX: [[1,2][2,2]]
                     return false if possible_checks.empty?
                     #need to see if the moves that can hit king are valid_game_moves
                     while !possible_checks.empty?
                        piece_input = [y,x]
                        move_input = possible_checks.first
                        return true if valid_game_move(piece_input, move_input, piece)
                        possible_checks.shift
                     end
                end
            end
        end
        return false
    end

    def hit_king?(king_pos, possible_moves)
        moves_array = []
        possible_moves.each do |pos|
            moves_array << pos if pos == king_pos
        end
        moves_array 
    end

    def king_pos(player)
        pos = ""
        self.game_board.board.each_with_index do |row,y|
            row.each_with_index do |col,x|
                pos = [y,x] if self.game_board.board[y][x] != " " && self.game_board.board[y][x].piece_type == "King" && self.game_board.board[y][x].player == player
            end
        end
        pos
    end

    def checkmate(player)
        #if check? returns true then we check if we can move king to any position that will get rid of check,
        #once we move king to a new position we check if king is still in check.
    end

    def winner(player)
        puts "#{player} has a checkmate. They win!"
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

    def rotate_board
        self.game_board.rotate_board
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

    def pawn_valid_moves(piece_input, move_input, piece)
        y, x = piece_input #current location input
        i, j = move_input #move to this location input

        return false if y == i && x == j

        if self.game_board.board[i][j] != " "
            return false if self.game_board.board[i][j].player == piece.player
        end

        if x == j #moving up one or two spaces
            y += 1
            while y < i 
                return false if self.game_board.board[y][x] != " " 
                y += 1
            end
        else #moving top-left or top-right
            if x < j #top-left case
                return true if self.game_board.board[i][j] != " " && self.game_board.board[i][j].player != piece.player
            else #top-right case
                return true if self.game_board.board[i][j] != " " && self.game_board.board[i][j].player != piece.player
            end
        end
        return true
    end

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

    def queen_valid_moves(piece_input, move_input, piece)
        return true if bishop_valid_moves(piece_input, move_input, piece) && rook_valid_moves(piece_input, move_input, piece)
        false
    end

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
#1. Get valid moves for each piece, so we can only moves pieces that aren't "blocked" by other pieces-------- DONE
#2. Implement check and checkmate feature (for win), after every move, look at the possible moves for each move of the oposing pieces -
# look at the moves (or look at the valid moves rather) and see if any oposing pieces can reach the position of the king -
#if it can reach position then that is check (also make sure you can't put yourself in check)
#if the king has no positions that aren't in check then it is a loss.

#Others: Pawn promotion, ability to repick a piece, Make letters turn into number ex: A == 0

Game.new(Player.new("james"),Player.new("adam"))


# if __FILE__ == $PROGRAM_NAME
#     puts "Welcome to Chess!"
#     puts "Player 1 enter name:"
#     player_1 = gets.chomp
#     puts "Player 2 enter name:"
#     player_2 = gets.chomp
#     Game.new(Player.new(player_1), Player.new(player2))
# end
