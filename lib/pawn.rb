class Pawn
    attr_accessor :value, :count, :player, :piece_type
    def initialize(player, value, type)
        @value = value
        @player = player
        @count = 0
        @piece_type = type
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
