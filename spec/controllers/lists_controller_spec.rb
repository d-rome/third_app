require 'spec_helper'

describe ListsController do
  render_views
  
  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create' (user makes a list)" do
    before(:each) do
      @test_user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      before(:each) do
        @attr = { :alias => "" }
      end
    
      it "should not create a list" do
        lambda do
          post :create, :list => @attr
          end.should_not change(List, :count)
      end
      
      it "should re-render the home page" do
        post :create, :list => @attr
        response.should render_template('pages/home')
      end
    end
    
    describe "success" do
      before(:each) do
        @attr =
          { :alias => "Januvia 100mg", :unit => "tablet", 
            :participating_manufacturer => "Merck",
            :url => "http://www.drugstore.com/januvia/100mg-tablets/qxn00006027731"
          }
      end
      
      it "should create a list" do
        lambda do
          post :create, :list => @attr
        end.should change(List, :count).by(1)
      end
      
      it "should redirect to the root path" do
        post :create, :list => @attr
        response.should redirect_to(root_path)
      end
      
      it "should have a flash success message" do
        post :create, :list => @attr
        flash[:success].should =~ /list created/i
      end
      
      
      
    end
    
  end
  
end
