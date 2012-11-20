require File.join(File.dirname(__FILE__), "/../../lib/shelter-setup/virtual_machine.rb" )

describe "Shelter::Setup::VirtualMachine" do
  
  describe "load configs" do
    before(:each) do
      @account_details = {
                                :login_name => 'login',
                                :fullname => 'Client Name',
                                :password => 'password',
                                :account_type => 'basic',
                                :parent_login => nil
                              }
      @domain_details = {
                            :domain_name => 'piesang.co.za'
                         }
                         
      @options = { :account_details => @account_details, :domain_details => @domain_details }
    end

     it "should be able to generate itself into a set of commands for a main account" do
      account = ProvisioningEngine::Services::Account.new(@options)
      commands = account.generate_commands
      commands.should have(2).elements
      # add the user
      commands[0].command.should == "/usr/local/hetzner/bin/adduser"
      commands[0].arguments.should == [ @account_details[:login_name], 
                                        @account_details[:fullname], 
                                        @account_details[:password],
                                        "/usr/bin/passwd",
                                        @domain_details[:domain_name] ]
    
      # set home directory permissions
      commands[1].command.should == "chmod"
      commands[1].arguments.should == [ "705",
                                          "/usr/www/users/login" ]
    end
    
    it "should be able to generate itself into a set of commands for domain redirect" do
      account = ProvisioningEngine::Services::Account.new(:account_details => @account_details.merge(:account_type => 'parkeddomain'), :domain_details => @domain_details)
      commands = account.generate_commands
      commands.should have(2).elements
      # add the user
      commands[0].command.should == "/usr/local/hetzner/bin/adduser"
      commands[0].arguments.should == [ @account_details[:login_name], 
                                          @account_details[:fullname], 
                                          @account_details[:password],
                                          "/bin/bash",
                                          @domain_details[:domain_name] ]
                                          
      # set home directory permissions
      commands[1].command.should == "chmod"
      commands[1].arguments.should == [ "040",
                                          "/usr/www/users/login" ]
    end
    
    it "should be able to generate itself into a set of commands for sub domains" do
      account = ProvisioningEngine::Services::Account.new( :account_details => @account_details.merge(:account_type => 'parked', :parent_login => 'wortel'), 
                                                     :domain_details => @domain_details )
      commands = account.generate_commands
      commands.should have(5).elements
      # add the user
      commands[0].command.should == "/usr/local/hetzner/bin/adduser"
      commands[0].arguments.should == [ @account_details[:login_name], 
                                          @account_details[:fullname], 
                                          @account_details[:password],
                                          "/bin/bash",
                                          @domain_details[:domain_name] ]
                                          
      # set home directory permissions
      commands[1].command.should == "chmod"
      commands[1].arguments.should == [ "040",
                                          "/usr/www/users/login" ]
      
      # create the parked document root
      commands[2].command.should == "mkdir"
      commands[2].arguments.should == [ "/usr/www/users/wortel/piesang.co.za" ]

      # create the parked document root
      commands[3].command.should == "chmod"
      commands[3].arguments.should == [ "755",
                                        "/usr/www/users/wortel/piesang.co.za" ]
     
      # set document root ownership
      commands[4].command.should == "chown"
      commands[4].arguments.should == [ "wortel:wortel",
                                        "/usr/www/users/wortel/piesang.co.za" ]
    
    end
    
    it "should be able to generate a set of command objects" do
      account = ProvisioningEngine::Services::Account.new( :account_details => @account_details.merge(:account_type => 'parked', :parent_login => 'wortel'), 
                                                     :domain_details => @domain_details )
      commands = account.generate_commands
      commands.should have(5).elements
      commands[0].should be_an_instance_of(ProvisioningEngine::Utils::Command)
      commands[1].should be_an_instance_of(ProvisioningEngine::Utils::Command)
      commands[2].should be_an_instance_of(ProvisioningEngine::Utils::Command)
    end
    
    it "should require a valid set of account details" do
      validate_account_details_argument(ProvisioningEngine::Services::Account, :login_name)
      validate_account_details_argument(ProvisioningEngine::Services::Account, :fullname)
      validate_account_details_argument(ProvisioningEngine::Services::Account, :password)
      validate_account_details_argument(ProvisioningEngine::Services::Account, :account_type)
    end

    it "should require a valid set of domain details" do
      validate_domain_details_argument(ProvisioningEngine::Services::Account, :domain_name)
    end
    
    it "should require a parent_login if account_type is parked" do
      lambda do
        ProvisioningEngine::Services::Account.new(:domain_details => @domain_details, :account_details => @account_details.merge(:account_type => 'parked', :parent_login => nil))
      end.should raise_error(ArgumentError, "Missing argument :parent_login")
    end
   
    it "should not setup user account if user exists" do
       login = get_current_user_login
       lambda do
         account = ProvisioningEngine::Services::Account.new(:domain_details => @domain_details, :account_details => @account_details.merge(:login_name => login))
         account.perform_validation!
       end.should raise_error(ProvisioningEngine::Errors::ValidationError, "Validation failed: Unix account already exists: #{login}")
    
    end

    it "should retrieve a list of account types" do
      account_types = ProvisioningEngine::Services::Account.defined_account_types
      account_types.include?("master").should == true
      account_types.include?("parkeddomain").should == true
      account_types.count.should == 9
    end
    
  end
  
end
