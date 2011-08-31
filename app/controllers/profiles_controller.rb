class ProfilesController < ApplicationController

  load_and_authorize_resource

  before_filter :only => :update do
    params[:profile].each_key do |key|
      params[:profile][key] = nil if params[:profile][key] == ''
    end
  end

  def show
    @wall_messages = @profile.user.wall_messages.latest_first.paginate :page => params[:page], 
      :per_page => 5
  end

  def edit

  end

  def update
    if @profile.update_attributes(params[:profile])
      unless @profile.user == current_user
        redirect_to(@profile.user, :notice => 'Profile was successfully updated.')
      else
        redirect_to(@profile, :notice => 'Profile was successfully updated.')
      end
    else
      render :action => :edit
    end
  end

  def update_status
    @profile = Profile.find(params[:profile_id])
    respond_to do |format|
      if @profile.update_status(params[:status])
        format.js { render(:layout => false) }
      end
    end    
  end

end
