class PublicClassPeopleUse
  def initialize
    # whatever
    @real_instance = SetupOnly.new
  end
  
  def setup
    after_setup_instance = @real_instance.setup
    @real_instance = after_setup_instance
  end
  
  delegate_missing_to :@real_instance
  
  class SetupOnly
    def setup
      # whatever
      AfterSetup.new(whatever,stuff,initializes,state)
    end
  end
  
  class AfterSetup
    def initialize(private_stuff,can_be_whatever)
      # ...
    end
    
    def method_called_only_after_setup
      # ...
    end
  end
end

# i = PublicClassPeopleUse.new
# i.method_called_only_after_setup
# => No Method Error [ could customize this somehow ]
# i.setup
# i.method_called_only_after_setup
# => WORKS!