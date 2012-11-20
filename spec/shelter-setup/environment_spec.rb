require File.join(File.dirname(__FILE__), "/../../lib/shelter-setup/environment.rb" )

describe "Shelter::Setup::Environment" do
  
  describe "load configs" do

    it "loads all environments" do
      environment = Shelter::Setup::Environment
      environment.all
    end 

  end

end
