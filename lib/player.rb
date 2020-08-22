class Player
    def initialize(player)
        @player = player
    end

    def get_input_piece
        puts "Select a piece:"
        pos = []
        puts "Enter y-position:"
        y_input = gets.chomp.to_i
        pos << y_input
        puts "Enter x-position:"
        x_input = gets.chomp.to_i
        pos << x_input
        pos
    end 

    def get_input_move
        puts "Move this piece:"
        pos = []
        puts "Enter y-position:"
        y_input = gets.chomp.to_i
        pos << y_input
        puts "Enter x-position:"
        x_input = gets.chomp.to_i
        pos << x_input
        pos
    end
end