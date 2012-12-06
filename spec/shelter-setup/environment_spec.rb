require File.join(File.dirname(__FILE__), "/../../lib/shelter-setup/environment.rb" )

describe "Shelter::Setup::Environment" do

  describe "#build_vagrant_file" do
    environment = Shelter::Setup::Environment.new('bacula')
    environment.build_vagrant_file
  end
  
  describe "#all" do

    describe "has bacula with virtual machine(s) including" do
      before(:all) do
        @environment = Shelter::Setup::Environment.new('bacula').virtual_machines
      end

      it "bacula director" do
        @environment.should include("baculadir")
      end
      it "baculareg" do
        @environment.should include("baculareg")
      end
      it "bacula storage daemon" do
        @environment.should include("baculasd")
      end
      it "dedi" do
        @environment.should include("dedi")
      end
      it "hetzner_api" do
        @environment.should include("hetzner_api")
      end
    end

    describe "has konsoleh with virtual machine(s) including" do
      before(:all) do
        @environment = Shelter::Setup::Environment.new('konsoleh').virtual_machines
      end

      it "hetzner_api" do
        @environment.should include("hetzner_api")
      end
      it "konsoleh" do
        @environment.should include("konsoleh")
      end
      it "dedi" do
        @environment.should include("dedi")
      end
      it "registrar_proxy" do
        @environment.should include("registrar_proxy")
      end
      it "aaapi" do
        @environment.should include("aaapi")
      end
      it "ldap" do
        @environment.should include("ldap")
      end
      it "pxe" do
        @environment.should include("pxe")
      end
    end

  end

end
