class ContactsController < ApplicationController

  def index
    @user = User.find_by_id params[:user_id]
    respond_to do |format|
      if @contacts = @user.try(:friends)
        format.html
      else
        format.html { redirect_to root_url }
      end
    end
  end

  def index_pending 
    @user = User.find_by_id params[:user_id]    
    respond_to do |format|
      if @contacts = @user.try(:potential_friends)
        format.html
      else
        format.html { redirect_to root_url }
      end
    end
  end

  def accept
    @contact = User.find_by_id params[:id]
    friendship = Friendship.unaccepted.where(:user_id => @contact.id, :target_id => current_user.id).first
    respond_to do |format|
      if friendship.try(:accept)
        format.js { render "redraw_contact_control", :layout => false }
      end   
    end
  end

  def propose
    @contact = User.find_by_id params[:id]
    respond_to do |format|
      if Friendship.create(:user => current_user, :target => @contact)
        format.js { render "redraw_contact_control", :layout => false }
      end   
    end
  end

  def destroy
    @contact = User.find_by_id params[:id]
    friendship = Friendship.where(:user_id => current_user.id, :target_id => @contact.id).first
    respond_to do |format|
      if friendship.try(:destroy)
        format.js { render "redraw_contact_control", :layout => false }
      end      
    end
  end

end