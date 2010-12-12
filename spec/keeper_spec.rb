require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Keeper" do
  before :each do
    @keeper = Keeper::Keeper.new
    ConditionVariable.stub(:new => @condvar = mock)
  end
  
  describe "#wait_for" do
    context "new event" do
      it "should create the event and wait for it" do
        @condvar.should_receive(:wait)
        @keeper.waiting.should == []
        @keeper.wait_for(:event)
        @keeper.waiting.should == [:event]
      end
    end
    
    context "existing event" do
      it "should re-use the existing signaller"
      it "should not affect any other waiting threads"
      it "should register the the calling thread as waiting"
    end
  end
  
  describe "#fire" do
    context "existing event" do
      it "should release all listeners"
    end
    
    context "non-existing event" do
      it "should not cause an error"
    end
  end
end
