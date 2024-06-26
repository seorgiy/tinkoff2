module Tinkoff
  class Payment
    attr_reader :terminal_key, :amount, :order_id, :success, :status,
                :payment_id, :error_code, :payment_url, :message, :details

    # Attributes for Cancel method
    attr_reader :original_amount, :new_amount

    # Attributes for AddCard method
    attr_reader :request_key

    # Attributes for RemoveCard method
    attr_reader :card_id

    def initialize(response)
      @terminal_key = response['TerminalKey']
      @amount = response['Amount']
      @order_id = response['OrderId']
      @success = response['Success']
      @status = response['Status']
      @payment_id = response['PaymentId']
      @error_code = response['ErrorCode']
      @payment_url = response['PaymentURL']
      @message = response['Message']
      @details = response['Details']

      # Attributes for Cancel method
      @original_amount = response['OriginalAmount']
      @new_amount = response['NewAmount']

      # Attributes for AddCard method
      @request_key = response['RequestKey']

      # Attributes for RemoveCard method
      @card_id = response['CardId']
    end

    def failure?
      !@success
    end

    def success?
      !failure?
    end
  end
end
