require 'yaml'
require File.join(File.dirname(__FILE__), "virtual_machine.rb" )

module Shelter
  module Setup
    class Environment

      def initialize(environment)
        @environment = environment
      end

      def build_vagrant_file
        virtual_machines.each do |vm_name|
          vm = Shelter::Setup::VirtualMachine.new(vm_name)
        end
      end

      def virtual_machines
        load_config[@environment]
      end

      def self.all
        load_config
      end

      private

      def load_config
        YAML.load_file(File.join(File.dirname(__FILE__),'..','config','environments.yml'))
      end

    end
  end
end
