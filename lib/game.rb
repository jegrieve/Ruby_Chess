require "./lib/board.rb"
require "./lib/player.rb"

class Game
    attr_accessor :board, :players, :game_board
    def initialize(player1,player2)
        @game_board = Board.new(player1, player2)
        @players = [player1,player2] #these will be player instances
        run
    end

    def run
        current_player = self.players.first
        piece_input = current_player.get_input_piece
        while !valid_piece?(piece_input, current_player)
            puts "Piece not valid, please choose a valid piece"
            piece_input = current_player.get_input_piece
        end
        piece = selected_piece(piece_input)
        p piece
        self.players.reverse!
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

end

Game.new(Player.new("james"),Player.new("adam"))


# if __FILE__ == $PROGRAM_NAME
#     puts "Welcome to Chess!"
#     puts "Player 1 enter name:"
#     player_1 = gets.chomp
#     puts "Player 2 enter name:"
#     player_2 = gets.chomp
#     Game.new(Player.new(player_1), Player.new(player2))
# end
