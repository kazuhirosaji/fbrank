# encoding: utf-8
require "./spec_helper"
require "../fbrank"

describe FbRank do
  context :"FIFAランキングデータ処理" do

    before do
      @fbrank = FbRank.new
      @esp = Hash[:macode, "ESP", :team_name, "Spain", :rank, 1, :zonal_rank, 1, :point , 1506]
      @por = Hash[:macode, "POR", :team_name, "Portugal", :rank, 4, :zonal_rank, 3, :point, 1219]
      @ger = Hash[:macode, "GER", :team_name, "Germany", :rank, 2, :zonal_rank, 2, :point, 1314]
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
        @fbrank.country_code_list.should == list
      end
    end

    it "list表示" do
      begin
        @fbrank.read "../short_nations.json"
        @fbrank.info(:ESP).should == @esp
        @fbrank.info(:POR).should == @por
        @fbrank.info("Germany").should == @ger
        @fbrank.info("Spain").should == @esp
      end
    end

    it "ranking取得" do
      begin
        @fbrank.read "../short_nations.json"
        @fbrank.rank(2).should == "Germany"
        @fbrank.rank(3).should == "Argentina"
        @fbrank.rank(3, 5).should == ["Argentina", "Portugal", "Colombia"]
      end
    end
    
    it "順位からlistを表示" do
      begin
        @fbrank.read "../short_nations.json"
        @fbrank.info(1).should == @esp
        @fbrank.info(4).should == @por
      end
    end
    
    it "頭文字で検索" do
      begin
        @fbrank.read "../short_nations.json"
        @fbrank.find_name("G").should == ["Germany"]
        @fbrank.find_name("S").should == ["Spain"]
        @fbrank.find_name("co").should == ["Colombia"]
      end
    end
  end

  context :"FIFAランキング本番データ処理" do

    before do
      @fbrank = FbRank.new
      @fbrank.read "../nations.json"

      @esp = Hash[:macode, "ESP", :team_name, "Spain", :rank, 1, :zonal_rank, 1, :point , 1506]
      @por = Hash[:macode, "POR", :team_name, "Portugal", :rank, 4, :zonal_rank, 3, :point, 1219]
      @ger = Hash[:macode, "GER", :team_name, "Germany", :rank, 2, :zonal_rank, 2, :point, 1314]
      @jpn = Hash[:maCode, "JPN", :team_name, "Japan",   :rank, 50, :zonal_rank, 2, :point, 601]
    end

    it "JSON読み込み" do
      begin
        # -- given --

        # -- when --
                  
        # -- then --
        @fbrank.nations.size.should > 0
        @fbrank.nations[:GER].rank == 2
        @fbrank.nations[:GER].name == "Germany"
        @fbrank.nations[:GER].zonal_rank == 2
        @fbrank.nations[:GER].point == 1314
      end
    end

    it "頭文字で検索" do
      begin
        @fbrank.find_name("ja").should == ["Jamaica", "Japan"]
        @fbrank.find_name("d").should == ["Denmark", "Djibouti", "Dominica", "Dominican Republic"]
        @fbrank.find_name("zz").should == []
      end
    end
  end
  
end
