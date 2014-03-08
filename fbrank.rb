require 'json'

class FbRank
  attr_accessor :nations
  def initialize
    p "init FbRank"
    @nations = {}
  end
  
  def read file
    File.open(file, "r") {|io|
      JSON.load(io).each do |nation|
#        p nation
        code = nation["maCode"].to_sym
        @nations[code] = Nations.new
        @nations[code].rank = nation["rank"].to_i
        @nations[code].name = nation["teamName"]
        @nations[code].zonal_rank = nation["zonalRank"].to_i
        @nations[code].point = nation["thisPoints"].to_i
        @nations[code].maCode = nation["maCode"]
      end
    }

    def country_list
      list = []
      @nations.each {|key, nation| list << nation.maCode }
      list
    end
  end
  
  class Nations
    attr_accessor :name, :rank, :zonal_rank, :point, :maCode
  end
end

#fbrank = FbRank.new
#fbrank.read "short_nations.json"
