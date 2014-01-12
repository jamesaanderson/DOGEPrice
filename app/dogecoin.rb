class Dogecoin
  class << self
    def toBtc(&block)
      AFMotion::JSON.get('http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=132') do |result|
        if result.success?
          json = result.object
          btcValue = json['return']['markets']['DOGE']['lasttradeprice']

          block.call(btcValue)
        end
      end
    end

    def toUsd(&block)
      self.toBtc do |btcValue|
        AFMotion::JSON.get('http://data.mtgox.com/api/1/BTCUSD/ticker_fast') do |result|
          if result.success?
            json = result.object
            usdValue = json['return']['buy']['value']

            block.call(usdValue.to_f * btcValue.to_f)
          end
        end
      end
    end
  end
end
