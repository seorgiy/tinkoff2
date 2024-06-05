module Tinkoff
  class Client
    # Инициирует платежную сессию и регистрирует заказ в системе Банка
    def self.init(order_id, amount, params = {})
      params = params.merge(Amount: amount, OrderId: order_id)
      as_payment(Tinkoff::Request.new('Init', params).perform)
    end

    # Данный метод используется, если продавец обладает сертификацией PCI DSS
    # и использует свою собственную платежную форму вместо формы банка.
    # TODO: Implement
    def self.finish_authorize(params = {})
      as_payment(Tinkoff::Request.new('FinishAuthorize', params).perform)
    end

    # Подтверждает платеж и осуществляет списание заблокированных ранее денежных средств
    def self.confirm(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      as_payment(Tinkoff::Request.new('Confirm', params).perform)
    end

    # Осуществляет рекуррентный (повторный) платеж — безакцептное списание денежных средств
    # со счета банковской карты Покупателя
    def self.charge(payment_id, rebill_id, params = {})
      params = params.merge(PaymentId: payment_id, RebillId: rebill_id)
      as_payment(Tinkoff::Request.new('Charge', params).perform)
    end

    # Отменяет платежную сессию
    def self.cancel(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      as_payment(Tinkoff::Request.new('Cancel', params).perform)
    end

    # Возвращает текуший статус платежа
    def self.state(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      as_payment(Tinkoff::Request.new('GetState', params).perform)
    end

    # Возвращает массив карт
    def self.card_list(customer_key, params = {})
      params = params.merge(CustomerKey: customer_key)
      Tinkoff::Card.list(Tinkoff::Request.new('GetCardList', params).perform)
    end 

    # Отвязать карту
    def self.remove_card(card_id, customer_key, params = {})
      params = params.merge(CardId: card_id, CustomerKey: customer_key)
      Tinkoff::Card.new(Tinkoff::Request.new('RemoveCard', params).perform)
    end 

    private

    def self.as_payment(response)
      Tinkoff::Payment.new(response)
    end
  end
end
