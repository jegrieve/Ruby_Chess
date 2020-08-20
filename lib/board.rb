require "./lib/pawn.rb"
class Board
    attr_accessor :board
    def initialize(player1, player2)
        @board = Array.new(8) {Array.new(8, " ")}
        @players = [player1, player2]
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

    def populate #just pawns for now, add other pieces later
        self.board.each_with_index do |row, y|
            row.each_with_index do |col, x|
                if y == 1 || y == 6
                self.board[y][x] = Pawn.new("test")
                end
            end
        end
    end
end

a = Board.new("A","B")
a.populate
a.display



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

