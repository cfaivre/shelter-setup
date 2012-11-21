require File.join(File.dirname(__FILE__), "/../../lib/shelter-setup/environment.rb" )

describe "Shelter::Setup::Environment" do

  describe "#build_vagrant_file" do
    environment = Shelter::Setup::Environment.new('bacula')
    environment.build_vagrant_file
  end
  
  describe "#all" do
    before(:all) do
#      environment = Shelter::Setup::Environment.new
      @environments = Shelter::Setup::Environment.all
    end

    describe "has bacula with virtual machine(s) including" do
      it "bacula director" do
        @environments["bacula"].include?("baculadir")
      end
      it "baculareg" do
        @environments["bacula"].include?("baculareg")
      end
      it "bacula storage daemon" do
        @environments["bacula"].include?("baculasd")
      end
      it "dedi" do
        @environments["bacula"].include?("dedi")
      end
      it "hetzner_api" do
        @environments["bacula"].include?("hetzner_api")
      end
    end

    describe "has konsoleh with virtual machine(s) including" do
      it "hetzner_api" do
        @environments["konsoleh"].include?("hetzner_api")
      end
      it "konsoleh" do
        @environments["konsoleh"].include?("konsoleh")
      end
    end

  end

end
