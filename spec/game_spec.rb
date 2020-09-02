require "./lib/game.rb"
describe Board do
    describe "#run" do 
        it "game should continue until checkmate occurs" do #run game until checkmate
            g = Game.new(Player.new("Jack"),Player.new("Mike"))
            expect(g).to eql(true)
        end

        it "game should continue until draw occurs" do #run game until draw
            g = Game.new(Player.new("Jack"),Player.new("Mike"))
            expect(g).to eql(true)
        end

        it "game should continue until exitoccurs" do #run game until exit
            g = Game.new(Player.new("Jack"),Player.new("Mike"))
            expect(g).to eql(true)
        end
    end
end