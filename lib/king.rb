class King
    attr_accessor :value
    def initialize(player, value)
        @value = value
        @player = player
    end

    def possible_moves(pos) 
        y, x = pos
        moves = []
        moves << top_moves(pos)
        moves << side_moves(pos)
        moves << bot_moves(pos)
        moves
    end

    def top_moves(pos)
        y, x = pos
        moves = []
        moves << [y - 1, x]
        moves << [y - 1, x + 1]
        moves << [y - 1, x - 1]
        moves
    end

    def bot_moves(pos)
        y, x = pos
        moves = []
        moves << [y + 1, x]
        moves << [y + 1, x + 1]
        moves << [y + 1, x - 1]
        moves
    end

    def side_moves(pos)
        y, x = pos
        moves = []
        moves << [y, x + 1]
        moves << [y, x - 1]
        moves
    end
end

a = King.new("a","b")
p a.possible_moves ([3,3])