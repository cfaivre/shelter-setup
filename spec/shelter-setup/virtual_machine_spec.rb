require File.join(File.dirname(__FILE__), "/../../lib/shelter-setup/virtual_machine.rb" )

describe "Shelter::Setup::VirtualMachine" do

  describe "#all" do
    before(:all) do
      vm = Shelter::Setup::VirtualMachine
      @virtual_machines = vm.all
    end

    describe "has bacula director virtual machine with" do
      it "host name - baculadir1.tst1.host-h.net" do
        @virtual_machines['baculadir']['host_name'].should == 'baculadir1.tst1.host-h.net'
      end
      it "host ip - 10.0.0.12" do
        @virtual_machines['baculadir']['host_ip'].should == '10.0.0.12'
      end
    end

    describe "has baculareg virtual machine with" do
      it "host name - baculareg.tst1.host-h.net" do
        @virtual_machines['baculareg']['host_name'].should == 'baculareg1.tst1.host-h.net'
      end
      it "host ip - 10.0.0.15" do
        @virtual_machines['baculareg']['host_ip'].should == '10.0.0.15'
      end
    end

    describe "has bacula storage daemon virtual machine with" do
      it "host name - baculasd1.tst1.host-h.net" do
        @virtual_machines['baculasd']['host_name'].should == 'baculasd1.tst1.host-h.net'
      end
      it "host ip - 10.0.0.11" do
        @virtual_machines['baculasd']['host_ip'].should == '10.0.0.11'
      end
    end

    describe "has dedi virtual machine with" do
      it "host name - dedi1.tst1.host-h.net" do
        @virtual_machines['dedi']['host_name'].should == 'dedi1.tst1.host-h.net'
      end
      it "host ip - 10.0.0.13" do
        @virtual_machines['dedi']['host_ip'].should == '10.0.0.13'
      end
    end

    describe "has hetzner_api virtual machine with" do
      it "host name - hetzner-api1.tst1.host-h.net" do
        @virtual_machines['hetzner_api']['host_name'].should == 'hetzner-api1.tst1.host-h.net'
      end
      it "host ip - 10.0.0.14" do
        @virtual_machines['hetzner_api']['host_ip'].should == '10.0.0.14'
      end
    end

  end
  
end
