
class Yelp
  # General-purpose record that allows passing a hash with parameters
  # to populate object attributes defined via methods like
  # +attr_reader+ or +attr_accessor+.
  
  require 'yelpster/configuration'
  class Record
    def initialize (params)
      defaults = Yelp.config
      defaults.merge! params
      defaults.each do |key, value| 
        name = key.to_s
        if not params[key].nil?
          value = params[key]
        end
        instance_variable_set("@#{name}", value) if respond_to?(name)
      end
    end
  end
end
