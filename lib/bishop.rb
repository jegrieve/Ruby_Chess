class Bishop
    attr_accessor :value
    def initialize(player, value)
        @value = value
        @player = player
    end

    def possible_moves(pos) 
        y, x = pos
        moves = []
    end
end