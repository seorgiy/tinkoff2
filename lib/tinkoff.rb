require 'httparty'
require 'active_support'
require 'active_support/core_ext/hash'

require 'tinkoff/request'
require 'tinkoff/request_e2c'
require 'tinkoff/client'
require 'tinkoff/e2c_client'
require 'tinkoff/payment'
require 'tinkoff/notification'
require 'tinkoff/card'

require 'tinkoff/version'

module Tinkoff
  include ActiveSupport::Configurable

  def self.tinkoff_params
    {
      TerminalKey: Tinkoff.config.terminal_key,
      TerminalE2cKey: Tinkoff.config.terminal_e2c_key,
      Password: Tinkoff.config.password,
      CertificateSerialNumber: Tinkoff.config.certificate_serial_number,
      E2cPrivateKeyPath: Tinkoff.config.e2c_private_key_path
    }
  end
end
