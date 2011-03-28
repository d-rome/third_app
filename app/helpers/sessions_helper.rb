module SessionsHelper
  
public
  
    def sign_in(user)
      cookies.permanent.signed[:remember_token] = [user.id, user.salt]
      current_user = user
    end
    
    def current_user=(user)
      @current_user = user
    end
    
    def current_user
      @current_user ||= user_from_remember_token
      # returns @current_user if the object exists and does not evaluate the rest of the
      # OR statement, user_from_remember_token which hits the database
    end
    
    def signed_in?
      !current_user.nil?
    end
    
    def current_user?(user)
      @user == current_user
    end
    
    def authenticate
      deny_access unless signed_in?
    end
    
    def sign_out
      cookies.delete(:remember_token)
      current_user = nil
    end

    def deny_access
      store_location
      redirect_to signin_path, :notice => "Please sign in to access this page."
    end

    def store_location
                                     # v this is a html tag
      session[:return_to] = request.fullpath
      #  ^ method that stores the location the user is trying to get to
    end
    
    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      clear_return_to
    end
    
    def clear_return_to
      session[:return_to] = nil
      # to clear the return_to location so the redirect_to goes to the inteded path  
    end


  private
  
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
  
end
