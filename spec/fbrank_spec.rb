# encoding: utf-8
require "./spec_helper"
require "../fbrank"

describe FbRank do
  context :データ読み込み do
    cases = [
      {
        case_no: 1,
        case_title: "読み込みデータ確認",
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          # -- given --
          fbrank = FbRank.new

          # -- when --
          p fbrank.rank
          fbrank.rank.should be_empty
          fbrank.rank.size.should == 0
          
          fbrank.read "nations.json"
          fbrank.rank.size.should > 0
          
          # -- then --
        end
      end

    end
  end

end
