require "./lib/pawn.rb"
require "./lib/rook.rb"
require "./lib/bishop.rb"
require "./lib/knight.rb"
require "./lib/queen.rb"
require "./lib/king.rb"



class Board
    attr_accessor :board
    def initialize
        @board = Array.new(8) {Array.new(8, " ")}
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

    def populate
        populate_pawns
        populate_top
        populate_bot
    end

    def populate_pawns #just pawns for now, add other pieces later
        board = self.board
        board.each_with_index do |row, y|
            row.each_with_index do |col, x|
                if y == 1 
                    board[y][x] = Pawn.new("test", "\u265F")
                elsif y == 6
                    board[y][x] = Pawn.new("test", "\u2659")
                end
            end
        end
    end

    def populate_top #populate non-pawn black pieces
        board = self.board
        board.each_with_index do |row, y|
            row.each_with_index do |col, x|
                if y == 0
                    if x == 0 || x == 7
                        board[y][x] = Rook.new("test", "\u265C")
                    elsif x == 1 || x == 6
                        board[y][x] = Knight.new("test", "\u265E")
                    elsif x == 2 || x == 5
                        board[y][x] = Bishop.new("test", "\u265D")
                    elsif x == 3
                        board[y][x] = Queen.new("test", "\u265B")
                    elsif x == 4
                        board[y][x] = King.new("test", "\u265A")
                    end
                end
            end
        end
    end

    def populate_bot #populate non-pawn white pieces
        board = self.board
        board.each_with_index do |row, y|
            row.each_with_index do |col, x|
                if y == 7
                    if x == 0 || x == 7
                        board[y][x] = Rook.new("test", "\u2656")
                    elsif x == 1 || x == 6
                        board[y][x] = Knight.new("test", "\u2658")
                    elsif x == 2 || x == 5
                        board[y][x] = Bishop.new("test", "\u2657")
                    elsif x == 3
                        board[y][x] = Queen.new("test", "\u2655")
                    elsif x == 4
                        board[y][x] = King.new("test", "\u2654")
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

a = Board.new
a.populate_top
a.populate
a.display
p a.valid_board_moves


#white pieces
# wking = "\u2654"
# puts wking.encode('utf-8')
# wqueen = "\u2655"
# puts wqueen.encode('utf-8')
# wrook = "\u2656"
# puts wrook.encode('utf-8')
# wbishop = "\u2657"
# puts wbishop.encode('utf-8')
# wknight = "\u2658"
# puts wknight.encode('utf-8')
# wpawn = "\u2659"
# puts wpawn.encode('utf-8')

#black pieces
# bking = "\u265A"
# puts bking.encode('utf-8')
# bqueen = "\u265B"
# puts bqueen.encode('utf-8')
# brook = "\u265C"
# puts brook.encode('utf-8')
# bbishop = "\u265D"
# puts bbishop.encode('utf-8')
# bknight = "\u265E"
# puts bknight.encode('utf-8')
# bpawn = "\u265F"
# puts bpawn.encode('utf-8')

