module Overwatch
  class Config
    def initialize
      load_yaml
      @checks = @raw_config[:checks]
      @events = @raw_config[:events]
      @storage = @raw_config[:storage]
    end
    
    def load_yaml
      @raw_config = YAML.load_file(Rails.root + 'config/overwatch.yml')
    end
    
    def checks
      @checks
    end
    
    def events
      @events
    end
    
    def storage
      @storage
    end
  end
end
