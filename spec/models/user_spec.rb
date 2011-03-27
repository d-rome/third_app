require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  it "should create a new instance given a valid attribute" do
     User.create!(@attr)
  end
  
  it "should require a name" do
     no_name_user = User.new(@attr.merge(:name => ""))
     no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
     no_email_user = User.new(@attr.merge(:email => ""))
     no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org first.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = "USER@EXAMPLE.COM"
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

# =========================================================
  describe "passwords" do
# =========================================================

    before(:each) do
      @user = User.new(@attr)
    end

    it "should exist as a User attribute" do
      @user.should respond_to(:password)
    end

    it "should also have a User password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end  
  end

# =========================================================
  describe "password validation" do
# =========================================================
  
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end
 
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 21
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

# =========================================================
  describe "password encryption" do
# =========================================================
    
    before(:each) do
      @test_user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @test_user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password attribute" do
      @test_user.encrypted_password.should_not be_blank
    end
    it "should have a salt" do
      @test_user.should respond_to(:salt)
    end


    describe "has_password? method" do

      it "should exist" do
        @test_user.should respond_to(:has_password?)
      end
      
      it "should return true if the passwords match" do
        @test_user.has_password?(@attr[:password]).should be_true
      end
      
      it "should respond false if the passwords don't match" do
        @test_user.has_password?("invalid").should be_false
      end
    end  


    describe "authentication method" do

      it "should respond with an object that exists" do
        User.should respond_to(:authenticate)
      end
      
      it "should return nil on email/password mismatch" do
        User.authenticate(@attr[:email], "wrongpass").should be_nil
      end
      
      it "should return nil for an email address with no stored user" do
        User.authenticate("bar@foo.com", @attr[:password]).should be_nil
      end
      
      it "should return the user object on a successful email/password match" do
        User.authenticate(@attr[:email], @attr[:password]).should == @test_user
      end
    end
  end
  
  describe "admin attribute" do
  
    before(:each) do
      @test_user = User.create!(@attr)
      #        this bang ^ causes the create method to raise an exception if it fails
    end
    
    it "should respond to admin" do
      @test_user.should respond_to(:admin)
    end
    
    it "should not be an admin by default" do
      @test_user.should_not be_admin
    end
    
    it "should be convertible to an admin" do
      @test_user.toggle!(:admin)
      #           ^ this bang toggles the boolean in the database
      @test_user.should be_admin
    end
  end
  
  describe "micropost associations" do
    
    before(:each) do
      @test_user = User.create(@attr)
      @ls1 = Factory(:list, :user => @test_user, :created_at => 1.day.ago)
      @ls2 = Factory(:list, :user => @test_user, :created_at => 1.hour.ago)
    end
    
    it "should have a lists attribute" do
      @test_user.should respond_to(:lists)
    end
    
    it "should have the right lists in the right order" do
      @test_user.lists.should == [@ls2, @ls1]
      
    end
    
    it "should destroy associated lists" do
      @test_user.destroy
      [@ls1, @ls2].each do |list|
        lambda do
          List.find(list)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
  end
  
  
end











