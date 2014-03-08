# encoding: utf-8
require "./spec_helper"
require "../fbrank"

describe FbRank do
  context :データ読み込み do

    before do
      @fbrank = FbRank.new
    end

    it "FbRank初期化" do
      begin
        # -- when --
                  
        # -- then --
        @fbrank.nations.should be_empty
        @fbrank.nations.size.should == 0
      end
    end

    it "JSON読み込み" do
      begin
        # -- given --

        # -- when --
        @fbrank.read "../short_nations.json"
                  
        # -- then --
        @fbrank.nations.size.should > 0
        @fbrank.nations[:GER].rank == 2
        @fbrank.nations[:GER].name == "Germany"
        @fbrank.nations[:GER].zonal_rank == 2
        @fbrank.nations[:GER].point == 1314
      end
    end

    it "国一覧表示" do
      begin
        # -- given --

        # -- when --
        @fbrank.read "../short_nations.json"
        
        # -- then --
        list = ["ESP", "GER", "ARG", "POR", "COL"]
        @fbrank.country_list.should == list
      end
    end

    it "list表示" do
      begin
        @fbrank.read "../short_nations.json"
        esp = Hash[:macode, "ESP", :team_name, "Spain", :rank, 1, :zonal_rank, 1, :point , 1506]
        por = Hash[:macode, "POR", :team_name, "Portugal", :rank, 4, :zonal_rank, 3, :point, 1219]
        @fbrank.info(:ESP).should == esp
        @fbrank.info(:POR).should == por
      end
    end
  end
end
