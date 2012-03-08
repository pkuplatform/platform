class BlogsController < ApplicationController
  before_filter :authenticate_user!
  layout 'activities_show'

  def show
    @blog = Blog.find(params[:id])
    @activity = @blog.activity
    @group = @activity.group
  end


  def new
    @activity = Activity.find(params[:activity_id])
    @group = @activity.group
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(params[:blog])
    @activity = Activity.find(params[:activity_id])
    @blog.author = current_user
    @blog.activity = @activity

    respond_to do |format|
      if @blog.save
        format.html { redirect_to activity_path(@activity), notice: 'blogs.create.successfully' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def index
    @activity = Activity.find(params[:activity_id])
    @blogs = @activity.blogs
    @group = @activity.group
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
        format.html { redirect_to activity_blog_path(@activity, @blog), notice: 'blogs.update.successfully' }
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
      format.html { redirect_to activity_path(@activity), notice: 'blogs.delete.successfully' }
      format.json { head :ok }
    end
  end

end
