require "./lib/board.rb"
class Game
    attr_accessor :board
    def initialize(player1, player2)
        @board = Board.new
        @players = [player2, player2] #these will be player instances
        run
    end

    def run
        player_turn = self.players
        while !win?(current_player)
            piece_input = current_player.get_input_piece
            move_input = current_player.get_input_move
        end
    end

    def display_board
        self.board.display
    end

    def rotate_board
        self.rotate_board
    end

    def win?(current_player)
        # current_player
    end
end


# if __FILE__ == $PROGRAM_NAME
#     puts "Welcome to Chess!"
#     puts "Player 1 enter name:"
#     player_1 = gets.chomp
#     puts "Player 2 enter name:"
#     player_2 = gets.chomp
#     Game.new(Player.new(player_1), Player.new(player2))
# end
a = Game.new("a","b")
a.display_board
a.rotate_board
a.display_board