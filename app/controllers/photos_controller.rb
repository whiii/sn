class PhotosController < ApplicationController

  before_filter :build_photo_in_album_if_can, :only => [:new, :create]

  load_and_authorize_resource

  def show
    
  end

  def new

  end

  def edit

  end

  def create

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @album }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @album }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy

    @photo.destroy
    redirect_to @photo.album
  end

  private

    def build_photo_in_album_if_can
      @album = Album.find_by_id params[:album_id]
      if can?(:manage, @album)
        @photo = @album.photos.build
      else
        redirect_to root_url
      end
    end
end
