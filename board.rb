class ChessBoard
    attr_accessor :board
    def initialize
        @board = Array.new(8) {Array.new(8, " ")}
    end

    def display
        puts "    A    B    C    D    E    F    G    H"
        self.board.each_with_index do |row,i1|
            puts "#{i1} #{row}"
        end
    end
end

 a = ChessBoard.new
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

