class WallMessagesController < ApplicationController

  def create
    @user = User.find_by_id(params[:user_id])
    @wall_message = WallMessage.new :user => @user, :sender => current_user, 
      :text => params[:text]
    respond_to do |format|
      if @wall_message.save
        format.js do
          @wall_messages = @user.wall_messages.latest_first.paginate :page => 1, 
            :per_page => 5
        end
      end
    end
  end

  def index
    respond_to do |format|
      format.js do
        @user = User.find_by_id params[:user_id]
        @wall_messages = @user.wall_messages.latest_first.paginate :page => params[:page], 
          :per_page => 5
      end
    end
  end

end