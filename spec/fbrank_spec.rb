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
      end
    end

  end
end
