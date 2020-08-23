class King
    attr_accessor :value, :player
    def initialize(player, value)
        @value = value
        @player = player
    end

    def possible_moves(pos) 
        y, x = pos
        moves = []
        top_moves(pos).each {|move| moves << move}
        side_moves(pos).each {|move| moves << move}
        bot_moves(pos).each {|move| moves << move}
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