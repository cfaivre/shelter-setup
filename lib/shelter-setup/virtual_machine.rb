require 'yaml'

module Shelter
  module Setup
    class VirtualMachine

      attr_accessor :host_ip
      attr_accessor :host_name
      attr_accessor :puppet_repo

      def initialize(vm)
        @virtual_machine = vm
        vm_settings = load_config[@virtual_machine]

        @host_name = vm_settings['host_name']
        @host_ip = vm_settings['host_ip']
        @puppet_repo = vm_settings['puppet_repo']
      end

      def self.all
        load_config
      end

      private

      def load_config
        YAML.load_file(File.join(File.dirname(__FILE__),'..','config','virtual_machines.yml'))
      end

    end
  end
end
