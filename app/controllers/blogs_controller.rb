class BlogsController < ApplicationController
  before_filter :authenticate_user!
  layout :resolve_layout

  private
  def resolve_layout
    case action_name
    when "new", "edit"
      "form"
    else
      "application"
    end
  end
  
  public
  def show
    @navi = :default
    @blog = Blog.find(params[:id])
    @activity = @blog.activity
  end


  def new
    @navi = :default
    @activity = Activity.find(params[:activity_id])
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(params[:blog])
    @activity = Activity.find(params[:activity_id])
    @blog.author = current_user
    @blog.activity = @activity

    respond_to do |format|
      if @blog.save
        format.html { redirect_to activity_path(@activity), notice: 'Blog was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def index
    @navi = :default
    @activity = Activity.find(params[:activity_id])
    @blogs = @activity.blogs
  end

  def edit
    @blog = Blog.find(params[:id])
    @activity = Activity.find(params[:activity_id])
    if !(can? :admin, @activity)
      redirect_to(@blog)
    end
  end

  def update
    @blog = Blog.find(params[:id])
    @activity = @blog.activity

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to activity_blog_path(@activity, @blog), notice: 'Activity was successfully updated.' }
        format.json { head :ok }
        format.js { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @activity = Activity.find(params[:activity_id])
    if can? :admin, @activity
      @blog.destroy
    end

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :ok }
    end
  end

end
