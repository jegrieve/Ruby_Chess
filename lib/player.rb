class Player
    attr_accessor :id
    def initialize(id)
        @id = id
    end

    def get_input_piece 
        puts "Select a piece:"
        pos = []
        alphabet_pos = ("A".."H").to_a + ("a".."h").to_a
        puts "Enter y-position:"
        y_input = gets.chomp.to_i
        pos << y_input
        puts "Enter x-position:"
        x_input = gets.chomp
        if alphabet_pos.include?(x_input)
            x_input = letter_position(x_input)
        else
            x_input = x_input.to_i
        end
        pos << x_input
        pos
    end 

    def get_input_move(piece) 
        puts "Move this #{piece.piece_type}"
        pos = []
        alphabet_pos = ("A".."H").to_a + ("a".."h").to_a
        puts "Enter y-position:"
        y_input = gets.chomp.to_i
        pos << y_input
        puts "Enter x-position:"
        x_input = gets.chomp
         if alphabet_pos.include?(x_input)
            x_input = letter_position(x_input)
         else
            x_input = x_input.to_i
         end
        pos << x_input
        pos
    end

    def letter_position(x_input)
        case x_input.upcase
        when "A"
            return 0
        when "B"
            return 1
        when "C"
            return 2
        when "D"
            return 3
        when "E"
            return 4
        when "H"
            return 5
        else
            return false
        end
    end
end
