require 'openssl'
require 'base64'

module Tinkoff
  class RequestE2c
    #BASE_URL = 'https://securepay.tinkoff.ru/e2c/v2/'
    BASE_URL = 'https://rest-api-test.tinkoff.ru/e2c/v2/'

    def initialize(path, params = {})
      @path = path
      @url = BASE_URL + path
      @digest_value = ''
      @signature_value = ''
      @params = params
    end

    def perform
      prepare_params

      response = HTTParty.post(
        @url,
        body: @params.to_json,
        debug_output: $stdout,
        :headers => {'Content-Type' => 'application/json'}
      )

      return response.parsed_response if @path == 'GetCardList' 

      Tinkoff::Payment.new(response.parsed_response)
    end

    private

    def prepare_params
      # Encode and join DATA hash
      # prepare_data
      @params.merge!({ TerminalKey: Tinkoff.tinkoff_params[:TerminalE2cKey],
                       X509SerialNumber: Tinkoff.tinkoff_params[:CertificateSerialNumber] })
      # Sort params by key
      @params = @params.sort.to_h

      generate_digest_value

      @params[:DigestValue] = @digest_value
      @params[:SignatureValue] = @signature_value
    end

    def generate_digest_value
      hex_digest = Digest::SHA256.hexdigest(request_values)
      bin_digest = hex_digest.scan(/../).map { |x| x.hex }.pack('c*')
      @digest_value = Base64.strict_encode64(bin_digest)

      k = OpenSSL::PKey::RSA.new(File.read(Tinkoff.tinkoff_params[:E2cPrivateKeyPath]))
      digest_alg = OpenSSL::Digest::SHA256.new
      signature = k.sign(digest_alg, bin_digest)

      @signature_value = Base64.strict_encode64(signature)
    end

    def request_values
      @params.except(:DigestValue, :SignatureValue, :X509SerialNumber)
             .stringify_keys
             .sort
             .to_h
             .values
             .join
    end
  end
end
