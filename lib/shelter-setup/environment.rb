require 'yaml'

module Shelter
  module Setup
    class Environment

    def initialize
    end

    def self.all
      load_config
    end

    private

    def self.load_config
      config = YAML.load_file('../../config/environments.yml')
      puts config.inspect
    end

    end
  end
end
