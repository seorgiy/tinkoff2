module Tinkoff
  class E2cClient
    def self.init(order_id, card_id, amount, params = {})
      params = params.merge(OrderId: order_id, CardId: card_id, Amount: amount)
      Tinkoff::RequestE2c.new('Init', params).perform
    end

    def self.payment(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      Tinkoff::RequestE2c.new('Payment', params).perform
    end

    def self.get_state(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      Tinkoff::RequestE2c.new('GetState', params).perform
    end

    def self.add_card(customer_key, params = {})
      params = params.merge(CustomerKey: customer_key)
      Tinkoff::RequestE2c.new('AddCard', params).perform
    end

    def self.remove_card(customer_key, card_id, params = {})
      params = params.merge(CustomerKey: customer_key, CardId: card_id)
      Tinkoff::RequestE2c.new('RemoveCard', params).perform
    end

    def self.add_customer(customer_key, params = {})
      params = params.merge(CustomerKey: customer_key)
      Tinkoff::RequestE2c.new('AddCustomer', params).perform
    end

    def self.get_customer(customer_key, params = {})
      params = params.merge(CustomerKey: customer_key)
      Tinkoff::RequestE2c.new('GetCustomer', params).perform
    end

    def self.remove_customer(customer_key, params = {})
      params = params.merge(CustomerKey: customer_key)
      Tinkoff::RequestE2c.new('RemoveCustomer', params).perform
    end

    def self.get_card_list(customer_key, params = {})
      raise StandardError.new "GetCardList is not implemented"
      #params = params.merge(CustomerKey: customer_key)
      #Tinkoff::RequestE2c.new('RemoveCustomer', params).perform
    end
  end
end
