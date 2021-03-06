require 'singleton'
require 'yelpster/configuration_hash'

class Yelp

  ##
  # Configuration options should be set by passing a hash:
  #
  #   Yelp.configure(
  #     :yws_id  => 'your_yws_id_here',
  #     ...
  #   )
  #
  def self.configure(options = nil)
    if !options.nil?
      Configuration.instance.configure(options)
    else
      Configuration.instance
    end
  end

  ##
  # Read-only access to the singleton's config data.
  #
  def self.config
    Configuration.instance.data
  end

  class Configuration
    include Singleton

    OPTIONS = [
      :yws_id,
      :consumer_key,
      :consumer_secret_key,
      :token,
      :token_secret,
      :compress_response,
      :response_format
    ]

    attr_accessor :data

    def self.set_defaults
      instance.set_defaults
    end

    OPTIONS.each do |o|
      define_method o do
        @data[o]
      end
      define_method "#{o}=" do |value|
        @data[o] = value
      end
    end

    def configure(options)
      @data.rmerge!(options)
    end

    def initialize # :nodoc
      @data = ConfigurationHash.new
      set_defaults
    end

    def set_defaults

      # yelpster default options
      @data[:yws_id]              = nil # for Yelp API v1
      @data[:consumer_key]        = nil # for Yelp API v2
      @data[:consumer_secret_key] = nil # for Yelp API v2
      @data[:token]               = nil # for Yelp API v2
      @data[:token_secret]        = nil # for Yelp API v2
      @data[:compress_response]   = true
      #@data[:response_format]     = 'json_to_ruby' #Yelp::ResponseFormat::JSON_TO_RUBY
    end

    instance_eval(OPTIONS.map do |option|
      o = option.to_s
      <<-EOS
      def #{o}
        instance.data[:#{o}]
      end

      def #{o}=(value)
        instance.data[:#{o}] = value
      end
      EOS
    end.join("\n\n"))

  end
end
