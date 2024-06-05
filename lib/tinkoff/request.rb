module Tinkoff
  class Request

    def initialize(path, params = {})
      base_url = Tinkoff.config[:base_url] || 'https://securepay.tinkoff.ru/v2/'
      @url = base_url + path
      @params = params
    end

    def perform
      prepare_params

      response = HTTParty.post(
        @url,
        body: @params.to_json,
        #debug_output: $stdout,
        :headers => {'Content-Type' => 'application/json'}
      )

      response.parsed_response
    end

    private

    def prepare_params
      # Encode and join DATA hash
      # prepare_data
      #
      # Add terminal key and password
      @params.merge!({TerminalKey: Tinkoff.tinkoff_params[:TerminalKey]})
      # Sort params by key
      @params = @params.sort.to_h
      # Add token (signature)
      @params[:Token] = token
    end

    # Params signature: https://oplata.tinkoff.ru/landing/develop/documentation/request_sign
    def token
      values = @params.except(:DATA, :Receipt, :Shops)
                      .merge({Password: Tinkoff.tinkoff_params[:Password]})
                      .stringify_keys
                      .sort
                      .to_h
                      .values
                      .join
      Digest::SHA256.hexdigest(values)
    end

    # Ключ=значение дополнительных параметров через “|”, например Email=a@test.ru|Phone=+71234567890
    def prepare_data
      return unless @params[:DATA].present?
      @params[:DATA] = @params[:DATA].to_query.tr('&', '|')
    end
  end
end
