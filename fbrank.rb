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
        #p nation
        code = nation["maCode"].to_sym
        @nations[code] = Nations.new
        @nations[code].rank = nation["rank"].to_i
        @nations[code].name = nation["teamName"]
        @nations[code].zonal_rank = nation["zonalRank"].to_i
        @nations[code].point = nation["thisPoints"].to_i
        @nations[code].macode = nation["maCode"]
      end
    }
  end

  def country_code_list
    clist = []
    @nations.each {|key, nation| clist << nation.macode }
    clist
  end
    
  def info name
    info = Hash.new
    nation = nil

    if name.is_a? Symbol
      nation = @nations[name]
    elsif name.is_a? String
      @nations.each do |key, val|
        nation = val if val.name  == name
      end
    elsif name.is_a? Integer
      # if name is Integer rank(integer) return nation name.
      return info(rank(name))
    end

    return if nation == nil

    info[:macode] = nation.macode
    info[:team_name] = nation.name
    info[:rank] = nation.rank
    info[:zonal_rank] = nation.zonal_rank
    info[:point] = nation.point
    info
  end

  def rank frm_num, to_num=0
    def rank_hit?(val, frm_num, to_num)
      val.rank  == frm_num || (val.rank >= frm_num && val.rank <= to_num)
    end

    names = []
    @nations.each do |key, val|
      if rank_hit?(val, frm_num, to_num)
        return val.name if to_num == 0
        names << val.name
      end
    end
    names
  end
  
  
  class Nations
    attr_accessor :name, :rank, :zonal_rank, :point, :macode
  end
end

#fbrank = FbRank.new
#fbrank.read "short_nations.json"
