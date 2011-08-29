class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def home
    redirect_to current_user.profile
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url
  end

end
