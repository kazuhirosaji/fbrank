class FbRank
  attr_accessor :rank
  def initialize
    p "init FbRank"
    @rank = []
  end
  
  def read file
    @rank << 1
  end
end