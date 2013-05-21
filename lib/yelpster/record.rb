class Yelp
  # General-purpose record that allows passing a hash with parameters
  # to populate object attributes defined via methods like
  # +attr_reader+ or +attr_accessor+.
  #
  class Record
    def initialize (params)
      
      defaults = config
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
