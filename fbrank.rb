require 'json'

class FbRank
  attr_accessor :nations
  def initialize
    p "init FbRank"
    @nations = []
  end
  
  def read file
    File.open(file, "r") {|io|
      @nations = JSON.load(io)
    }
  end
  
  class Nations
    attr_accessor :name, :rank, :area
    def initialize
      @rank = 0
    end
  end
end

#fbrank = FbRank.new
#fbrank.read "short_nations.json"
