class AlbumsController < ApplicationController

  before_filter :provide_new_album, :only => :create

  load_and_authorize_resource

  def index
    @user = User.find_by_id params[:user_id]
    if @user && @user != current_user
      @albums = @user.albums
    else
      @new_album = Album.new
      @albums = current_user.albums
    end
  end

  def show
    
  end

  def create
    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to user_albums_url(@album.user) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @album.destroy
    redirect_to user_albums_url(@album.user)
  end

  private
    
    def provide_new_album
      @album = current_user.albums.build
    end

end
