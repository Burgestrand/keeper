require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Keeper" do
  before :each do
    @keeper = Keeper::Keeper.new
    ConditionVariable.stub(:new => @condvar = mock)
  end
  
  context "non-existing event" do
    before :each do
      @keeper.waiting.should == []
    end
    
    describe "#wait_for" do
      it "should create the event and wait for it" do
        ConditionVariable.should_receive(:new).once
        @condvar.should_receive(:wait).once
        
        @keeper.wait_for(:event)
        @keeper.waiting.should == [:event]
      end
    end
    
    describe "#fire" do
      it "should not cause an error" do
        expect { @keeper.fire(:bogus_event) }.to_not raise_error
      end
    end
  end
  
  context "existing event" do
    before :each do
      @condvar.should_receive(:wait).once
      @keeper.wait_for(:event)
    end
    
    describe "#wait_for" do
      it "should re-use the existing signaller" do
        ConditionVariable.should_not_receive(:new)
        @condvar.should_receive(:wait).once # to raise expectation
        @keeper.wait_for(:event)
      end
    
      it "should wait for the event" do
        @condvar.should_receive(:wait).once
        @keeper.wait_for(:event)
      end
    end
    
    describe "#fire" do
      it "should release all listeners" do
        @condvar.should_receive(:broadcast).once
        @keeper.fire(@keeper.waiting.first)
      end
    end
  end
end
