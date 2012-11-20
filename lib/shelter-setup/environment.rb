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
      YAML.load_file(File.join(File.dirname(__FILE__),'..','config','environments.yml'))
    end

    end
  end
end
