require 'httparty'
require 'active_support'
require 'active_support/core_ext/hash'

require 'tinkoff/request'
require 'tinkoff/client'
require 'tinkoff/payment'
require 'tinkoff/notification'

require 'tinkoff/version'

module Tinkoff
  include ActiveSupport::Configurable

  def self.tinkoff_params
    {
      TerminalKey: Tinkoff.config.terminal_key,
      Password: Tinkoff.config.password
    }
  end
end
