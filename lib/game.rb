require "./lib/board.rb"
require "./lib/player.rb"
require "yaml"
class Game
    attr_accessor :game_board, :players
    def initialize(player1, player2)
        @game_board = Board.new(player1, player2)
        @players = [player1, player2]
        run
    end

    def run
        while true 
        current_player = self.players.first
        puts "#{current_player.id}'s turn"
        h = help(current_player)
        break if h == "exited"
        break if h == "draw"
        display_board
        if check?(current_player)
                checkmate = in_check(current_player)
                 if checkmate == true
                    check_mate(current_player)
                    puts "Game Over! #{current_player.id} loses, and #{self.players.last.id} wins!"
                    return
                 end
                 self.players.reverse!
                 self.game_board.rotate_board
        else
        piece_input = valid_piece_input(current_player.get_input_piece, current_player) 
        piece = selected_piece(piece_input)
        move_input = valid_move_input(piece_input, current_player.get_input_move(piece), piece, current_player)
        piece = promote_pawn(current_player, piece.value) if promotion?(move_input)
        place_piece(piece_input, move_input, piece)
        display_board
        self.players.reverse!
        self.game_board.rotate_board
        end 
    end
        puts "Game exited"
    end

    def help(current_player)
        puts "Commands: (P) to play a move, (D) to offer a draw (S) to save current game (E) to exit game"
        case gets.chomp.upcase

        when "P"
            return
        when "D"
            draw = offer_draw(current_player)
            if draw
                puts "Game is a draw"
                return "draw"
            else
                puts "Game is not a draw, continue."
            end
        when "S"
            File.write("chess_game_save.yaml", $g.to_yaml)
        when "E"
            "exited"
        else
            puts "invalid command, please enter a valid command"     
            help       
        end
    end

    def display_board
        self.game_board.display
    end

    def offer_draw(current_player)
        puts "#{current_player.id} would like to draw, accept? (Y/N)"
        input = gets.chomp
        return true if input.upcase == "Y"
        false
    end

    def in_check(current_player) 
        display_board
        puts "#{current_player.id} is in check! Get your king out of check!"
        piece_input = valid_piece_input(current_player.get_input_piece, current_player) 
        piece = selected_piece(piece_input)

        move_input = valid_move_input(piece_input, current_player.get_input_move(piece), piece, current_player)
        y, x = move_input
        i, j = piece_input
        old_piece = self.game_board.board[y][x]
        place_piece(piece_input, move_input, piece)
        display_board
        if check?(current_player)
            puts "Piece reverted back to original position because you're still in check! Can you move out of check?"
            self.game_board.board[y][x] = old_piece
            self.game_board.board[i][j] = piece
            display_board
            puts "Does opponent have checkmate? (Y / N) "
            input = gets.chomp
            return true if input.upcase == "Y"
            in_check(current_player)
        end
    end

    def check_mate(current_player)
        puts "#{current_player.id} has been checkmated!"
    end

    def valid_piece_input(pos, player)
        piece_input = pos
        while !valid_piece?(piece_input, player)
            puts "Piece not valid, please choose a valid piece"
            piece_input = player.get_input_piece
        end
        piece_input
    end

    def valid_piece?(pos, player)
        y, x = pos
        piece = self.game_board.board
        return false if piece[y] == nil || piece[y][x] == nil || piece[y][x] == " " || piece[y][x].player != player.id
        true
    end

    def selected_piece(pos)
        y, x = pos
        self.game_board.board[y][x]
    end

    def valid_move_input(piece_pos, piece_move_pos, piece, player)
        move_pos = piece_move_pos
        while !valid_move?(piece_pos, move_pos, piece) || !valid_game_move?(piece_pos, piece_move_pos, self.game_board.board, piece)
            puts "Move not valid, please choose a valid move"
            move_pos = player.get_input_move(piece)
        end
        move_pos
    end

    def valid_move?(piece_pos, piece_move_pos, piece)
        return true if self.game_board.valid_board_moves.include?(piece_move_pos) && piece.possible_moves(piece_pos).include?(piece_move_pos)
        false
    end

    def valid_game_move?(piece_pos, piece_move_pos, board, piece)
        case piece.piece_type
        when "Rook"
           return true if piece.rook_valid_moves(piece_pos, piece_move_pos, board)
           false  
        when "Pawn"
           return true if piece.pawn_valid_moves(piece_pos, piece_move_pos, board)
           false 
        when "Knight"
           return true if piece.knight_valid_moves(piece_pos, piece_move_pos, board)
           false  
        when "Bishop"
           return true if piece.bishop_valid_moves(piece_pos, piece_move_pos, board)
           false  
        when "Queen"
           return true if piece.queen_valid_moves(piece_pos, piece_move_pos, board)
           false  
        when "King"
           return true if piece.king_valid_moves(piece_pos, piece_move_pos, board)
           false  
        end
    end

    def place_piece(piece_input, piece_move_pos, piece)
        y, x = piece_input
        j, i = piece_move_pos
        board = self.game_board.board
        board[y][x] = " "
        board[j][i] = piece
    end

    def check?(player)
        self.game_board.board.each_with_index do |row,y|
            row.each_with_index do |piece,x|
                if piece != " " && piece.player != player.id
                    possible_moves = piece.possible_moves([y,x])

                    player_king_pos = king_pos(player)

                    possible_checks = hit_king?(player_king_pos, possible_moves)
                    board = self.game_board.board

                    while !possible_checks.empty?
                        piece_input = [y,x]
                        move_input = possible_checks.first
                        return true if valid_game_move?(piece_input, move_input, board, piece)
                        possible_checks.shift
                    end
                end
            end
        end
        false
    end

    def king_pos(player)
        pos = ""
        self.game_board.board.each_with_index do |row, y|
            row.each_with_index do |piece, x|
                if piece != " " && piece.piece_type == "King" && piece.player == player.id
                    pos = [y,x]
                end
            end
        end
        pos
    end

    def hit_king?(king_pos, possible_moves)
        moves = []
        possible_moves.each do |pos|
            if pos == king_pos
                moves << pos 
            end
        end
        moves
    end

    #------- Pawn Promotion --------

    def promotion?(pos)
        y, x = pos
        if y == 0
            return true
        end
        false
    end

    def promote_pawn(player, pawn_value)
        puts "Choose a new piece (Ex: R for Rook, K for Knight)"
        piece = gets.chomp
        valid_letters = ["R","K","Q","B"]
        while !valid_letters.include?(piece.upcase)
            puts "Please choose valid piece (R,K,Q,B)"
            piece = gets.chomp
        end
        piece_selected(piece, player, pawn_value)
     end

     def piece_selected(piece, player, pawn_value)
       case piece.upcase
       when "R"
            return Rook.new(player.id, "\u2656","Rook") if pawn_value == "\u2659"
            Rook.new(player.id, "\u265C", "Rook")
       when "K"
            return Knight.new(player.id,"\u2658","Knight") if pawn_value == "\u2659"
            Knight.new(player.id, "\u265E", "Knight")
       when "B"
            return Bishop.new(player.id,"\u2657" ,"Bishop") if pawn_value == "\u2659"
            Bishop.new(player.id, "\u265D", "Bishop")
       when "Q"
            return Queen.new(player.id,"\u2655","Queen") if pawn_value == "\u2659"
            Queen.new(player.id, "\u265B", "Queen")
       end
     end

     #YAML methods

     def to_yaml
        YAML.dump ({
          :game_board => @game_board,
          :players => @players,
        })
      end
    
      def self.from_yaml(string)
        data = YAML.load(string)
        self.new(data[:game_board], data[:players]) #basically this is Game.new(player.new(), player.new) but the inputs are wrong
      end
end

#To-Do:
#OFFER DRAW
#Serialize/save game
#Fix pawn 2 moves opener
#Player tests/Game Tests
#push to TOP

#a = Game.new(Player.new("James"), Player.new("Adam"))

if __FILE__ == $PROGRAM_NAME
    puts "Welcome to Chess!"
    puts "New game (N) or load previous game (L)?"
    game_input = gets.chomp
    if game_input.upcase == "N"
    puts "Player 1 enter name:"
    player_1 = gets.chomp
    puts "Player 2 enter name:"
    player_2 = gets.chomp
    $g = Game.new(Player.new(player_1), Player.new(player_2))
    elsif game_input.upcase == "L"
    Game.from_yaml(File.open("chess_game_save.yaml"))
    else
    puts "That command is not recognized"
    end
end
