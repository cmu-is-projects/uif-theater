class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
	  flash[:error] = "You are not authorized to access this page. If you think this is a mistake, please contact the administrator. "
	  redirect_to root_url
  end
end
