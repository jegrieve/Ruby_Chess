require "./lib/pawn.rb"
require "./lib/rook.rb"
require "./lib/bishop.rb"
require "./lib/knight.rb"
require "./lib/queen.rb"
require "./lib/king.rb"
class Board
    attr_accessor :board
    def initialize(player1, player2)
        @board = Array.new(8) {Array.new(8, " ")}
        populate(player1.id, player2.id)
    end

    def display
        puts "    A    B    C    D    E    F    G    H"
        display_array = []

        self.board.each do |row|
            subarray = []
            row.each do |el|
                if el == " "
                    subarray << el
                else
                    subarray << el.value
                end
            end
            display_array << subarray
        end

        display_array.each_with_index do |row, i1|
            puts "#{i1} #{row}"
        end
    end
    
    def rotate_board
        self.board.reverse!
        self.board.each do |row|
            row.reverse!
        end
    end

    def populate(player1, player2)
        populate_pawns(player1, player2)
        populate_top(player1, player2)
        populate_bot(player1, player2)
    end

    def populate_pawns(player1, player2)
        board = self.board
        board.each_with_index do |row, y|
            row.each_with_index do |col, x|
                if y == 1 
                    board[y][x] = Pawn.new(player2, "\u265F", "Pawn")
                elsif y == 6
                    board[y][x] = Pawn.new(player1, "\u2659", "Pawn")
                end
            end
        end
    end

    def populate_top(player1, player2) #populate non-pawn black pieces
        board = self.board
        board.each_with_index do |row, y|
            row.each_with_index do |col, x|
                if y == 0
                    if x == 0 || x == 7
                        board[y][x] = Rook.new(player2, "\u265C", "Rook")
                    elsif x == 1 || x == 6
                        board[y][x] = Knight.new(player2, "\u265E", "Knight")
                    elsif x == 2 || x == 5
                        board[y][x] = Bishop.new(player2, "\u265D", "Bishop")
                    elsif x == 3
                        board[y][x] = Queen.new(player2, "\u265B", "Queen")
                    elsif x == 4
                        board[y][x] = King.new(player2, "\u265A", "King")
                    end
                end
            end
        end
    end

    def populate_bot(player1, player2) #populate non-pawn white pieces
        board = self.board
        board.each_with_index do |row, y|
            row.each_with_index do |col, x|
                if y == 7
                    if x == 0 || x == 7
                        board[y][x] = Rook.new(player1, "\u2656", "Rook")
                    elsif x == 1 || x == 6
                        board[y][x] = Knight.new(player1, "\u2658", "Knight")
                    elsif x == 2 || x == 5
                        board[y][x] = Bishop.new(player1, "\u2657", "Bishop")
                    elsif x == 3
                        board[y][x] = Queen.new(player1, "\u2655", "Queen")
                    elsif x == 4
                        board[y][x] = King.new(player1, "\u2654", "King")
                    end
                end
            end
        end

        def valid_board_moves
            moves = []
            self.board.each_with_index do |row, i|
                j = 0
                while j < 8
                    move = []
                    move << j
                    move << i
                    moves << move
                    j += 1
                end
            end
            moves
        end
    end
end
