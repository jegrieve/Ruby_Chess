class Pawn
    attr_accessor :value, :count
    def initialize(player, value)
        @value = value
        @piece = "Pawn"
        @player = player
        @count = 0
    end

    def possible_moves(pos) 
        y, x = pos
        moves = []
        if self.count == 0 
            moves << [y - 1, x]
            moves << [y - 2, x]
            self.count += 1
        else
            moves << [y - 1, x]
            moves << [y - 1, x + 1]
            moves << [y - 1, x - 1]
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
p a.possible_moves([3,3])
