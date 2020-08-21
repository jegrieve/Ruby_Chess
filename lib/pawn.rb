class Pawn
    attr_accessor :value, :count
    def initialize(player, value)
        @value = value
        @player = player
        @count = 0
    end

    def possible_moves(pos) #only forward move for now
        y, x = pos
        moves = []
        if self.count == 0 #forward move
            moves << [y - 1, x]
            moves << [y - 2, x]
            self.count += 1
        else
            moves << [y - 1, x]
        end
        moves
    end

    #  def promotion(pos)
    #     y, x = pos
    #     if y == 0
    #         puts "Choose a new piece"
    #         piece = gets.chomp
    #     end
    #  end
end
a = Pawn.new("a", "b")
p a.possible_moves([0,0])