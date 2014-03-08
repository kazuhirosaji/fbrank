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
        p nation
        code = nation["maCode"].to_sym
        @nations[code] = Nations.new
        @nations[code].rank = nation["rank"].to_i
        @nations[code].name = nation["teamName"]
        @nations[code].zonal_rank = nation["zonalRank"].to_i
        @nations[code].point = nation["thisPoints"].to_i
        @nations[code].macode = nation["maCode"]
      end
    }

    def country_list
      clist = []
      @nations.each {|key, nation| clist << nation.macode }
      clist
    end
    
    def info name
      info = Hash.new
      
      info[:macode] = @nations[name].macode
      info[:team_name] = @nations[name].name
      info[:rank] = @nations[name].rank
      info[:zonal_rank] = @nations[name].zonal_rank
      info[:point] = @nations[name].point
      info
    end
  end
  
  class Nations
    attr_accessor :name, :rank, :zonal_rank, :point, :macode
  end
end

#fbrank = FbRank.new
#fbrank.read "short_nations.json"
