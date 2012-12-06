require 'yaml'
require File.join(File.dirname(__FILE__), "virtual_machine.rb" )

module Shelter
  module Setup
    class Environment

      def initialize(environment)
        @environment = environment
      end

      def build_vagrant_file
        virtual_machines_names.each do |vm_name|
          vm = Shelter::Setup::VirtualMachine.new(vm_name)
        end

      end

      def self.all
        load_config
      end

      private

      def load_config
        YAML.load_file(File.join(File.dirname(__FILE__),'..','config','environments.yml'))
      end

      def virtual_machines_names
        load_config[@environment]
      end
    end
  end
end
