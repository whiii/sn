class UsersController < ApplicationController

  load_and_authorize_resource :except => :daily_stats

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def search
    if @search_string = params[:search_string]
      @users = User.search @search_string, :page => params[:page], :per_page => 10
    else
      @users = User.paginate :page => params[:page], :per_page => 10 
    end
  end

  def create
    @user = User.new(params[:user])
    @user.confirmed_at = Time.now;
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
    end
  end

  def daily_stats
    authorize! :view_stats, User
    from = Date.parse params[:from]
    to = Date.parse params[:to]
    respond_to do |format|
      format.html
      format.xml do 
        @stats = User.get_daily_stats(from, to)
        render(:layout => false)
      end
    end
  end

end