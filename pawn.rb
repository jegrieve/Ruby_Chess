class Pawn
    attr_accessor :value
    def initialize(name, color)
        @value = "\u2654"
        @name = player
        @color = color
        @count = 0
    end

    def possible_moves(pos, attack = false) #only forward move for now
        y, x = pos
        moves = []
        if count == 0 #forward move
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
