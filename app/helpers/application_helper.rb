module ApplicationHelper

  def sign_out_link
    link_to "Sign out", destroy_user_session_path, :method => :delete, :id => "sign_out_link"
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
