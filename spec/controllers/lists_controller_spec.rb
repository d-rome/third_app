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
        @attr = { :alias => "Lorem ipsum dolor sit amet" }
      end
      
      it "should create a list" do
        lambda do
          post :create, :list => @attr
        end.should change(List, :count).by(1)
      end
      
      
      
    end
    
  end
  
end
