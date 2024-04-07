class ApplicationController < ActionController::Base
  # Define a helper method to make current_user available in views
  helper_method :current_user

  # Rescue from a CanCan access denied exception
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  private

  # Temporary current_user method
  def current_user
    # Assuming you're storing the user's ID in the session under :user_id
    # Adjust the logic here according to your authentication strategy
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
