require File.join(File.dirname(__FILE__), "/../../lib/shelter-setup/environment.rb" )

describe "Shelter::Setup::Environment" do
  
  describe "#all" do
    before(:all) do
      environment = Shelter::Setup::Environment
      @environments = environment.all
    end

    describe "has bacula with virtual machine(s) including" do
      it "bacula director" do
        @environments["bacula"].should include("baculadir")
      end
      it "baculareg" do
        @environments["bacula"].should include("baculareg")
      end
      it "bacula storage daemon" do
        @environments["bacula"].should include("baculasd")
      end
      it "dedi" do
        @environments["bacula"].should include("dedi")
      end
      it "hetzner_api" do
        @environments["bacula"].should include("hetzner_api")
      end
    end

    describe "has konsoleh with virtual machine(s) including" do
      it "hetzner_api" do
        @environments["konsoleh"].should include("hetzner_api")
      end
      it "konsoleh" do
        @environments["konsoleh"].should include("konsoleh")
      end
      it "dedi" do
        @environments["konsoleh"].should include("dedi")
      end
      it "registrar_proxy" do
        @environments["konsoleh"].should include("registrar_proxy")
      end
      it "aaapi" do
        @environments["konsoleh"].should include("aaapi")
      end
      it "ldap" do
        @environments["konsoleh"].should include("ldap")
      end
      it "pxe" do
        @environments["konsoleh"].should include("pxe")
      end
    end

  end

end
