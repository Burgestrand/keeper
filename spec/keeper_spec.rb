require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Keeper" do
  describe "#wait_for" do
    context "new event" do
      it "should create the event signaller"
      it "should register the calling thread as waiting"
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
