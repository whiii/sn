class ProfilesController < ApplicationController

  load_and_authorize_resource

  def show
    @wall_messages = @profile.user.wall_messages.latest_first.paginate :page => params[:page], 
      :per_page => 5
  end

  def edit

  end

  def update
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
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
