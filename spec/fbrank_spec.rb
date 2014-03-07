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
          case_before c

          # -- given --
          fbrank = FbRank.new

          # -- when --
          p fbrank.rank
          fbrank.rank.should be_empty
          fbrank.rank.size.should == 0
          # -- then --
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case after
      end

      def case_after(c)
        # implement each case after
      end
    end
  end

end
