require 'spec_helper'

describe List do

  before(:each) do
    @test_user = Factory(:user)
    @attr = {
      :alias => "Januvia 100mg",
      :unit => "tablet",
      :participating_manufacturer => "Merck",
      :quantity => 30,
      :latest_price_cents => 68882,
      :latest_price_currency => "USD",
      :url => "http://www.drugstore.com/januvia/100mg-tablets/qxn00006027731"
    }
  end

  it "should create a new instance with valid attributes" do
    @test_user.lists.create!(@attr)
#    List.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @list = @test_user.lists.create(@attr)
    end

    it "should have a user attribute" do
      @list.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @list.user_id.should == @test_user.id
      @list.user.should == @test_user
    end
  end
end


