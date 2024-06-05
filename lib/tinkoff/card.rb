module Tinkoff
  class Card
    attr_reader :card_id, :pan, :status, :rebill_id, :card_type, :exp_date

    def initialize(response)
      @card_id = response['CardId']
      @pan = response['Pan']
      @status = response['Status']
      @rebill_id = response['RebillId']
      @card_type = response['CardType']
      @exp_date = response['ExpDate']
    end

    def self.list(array)
      array.map(&method(:new))
    end
  end
end
