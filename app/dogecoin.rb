class Dogecoin
  class << self
    def toBtc(&block)
      AFMotion::JSON.get('http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=132') do |result|
        if result.success?
          json = result.object
          btcValue = json[:return][:markets][:DOGE][:lasttradeprice]

          block.call(btcValue)
        end
      end
    end
  end
end
