require "global_store/version"
require 'global_store/store'
require 'request_store'

module GlobalStore
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(self.configuration)
  end

  def self.reset_configuration!
    self.configuration = Configuration.new
  end

  class Configuration

    def key_prefix=(prefix)
      @key_prefix = prefix
    end

    def key_prefix
      @key_prefix.nil? ? "global_store" : @key_prefix
    end

    def storage
      @storage.nil? ? RequestStore : @storage
    end

    def storage=(storage)
      @storage = storage
    end

  end


end
