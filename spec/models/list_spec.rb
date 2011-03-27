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
  
  describe "validations" do
    
    it "should have a user id" do
      List.new(@attr).should_not be_valid
    end
    
    it "should require a nonblank alias" do
#      @test_user.lists.build(:alias => "   ").should_not be_valid
      @test_user.lists.new(@attr.merge(:alias => "")).should_not be_valid
    end

    it "should require a nonblank unit" do
      @test_user.lists.new(@attr.merge(:unit => "")).should_not be_valid
    end

    it "should require a nonblank participating manufacturer" do
      @test_user.lists.new(@attr.merge(:participating_manufacturer => "")).should_not be_valid
    end

    it "should require a nonblank url" do
      @test_user.lists.new(@attr.merge(:url => "")).should_not be_valid
    end
    
    it "should reject long aliases" do
      @test_user.lists.new(@attr.merge(:alias => "a" * 51)).should_not be_valid
    end

    it "should reject long units" do
      @test_user.lists.new(@attr.merge(:unit => "a" * 21)).should_not be_valid
    end
    
    it "should reject long participating manufactuerers" do
      @test_user.lists.new(@attr.merge(:participating_manufacturer => "a" * 51)).should_not be_valid
    end

    it "should reject long urls" do
      @test_user.lists.new(@attr.merge(:url => "a" * 201)).should_not be_valid
    end


  end
  
end


