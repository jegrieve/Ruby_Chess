require "./lib/board.rb"
require "./lib/player.rb"
describe Board do
    describe "#initialize" do 
        it "should create a 8x8 grid" do
            brd = Board.new(Player.new("Jack"), Player.new("Mike"))
            count = 0
            brd.board.each do |row|
                row.each do |col|
                    count += 1
                end
            end
            expect(count).to eql(64)
        end
    end
end