class BlogsController < ApplicationController
  def show
    @blog = Blog.find(params[:id])
    @activity = @blog.activity
  end

  def comment
    @blog = Blog.find(params[:id])
    @comment = @blog.comments.create(:user=>current_user,:body=>params["comment-content"])
 
    respond_to do |format|
      format.js
    end
  end

  def new
    @activity = Activity.find(params[:id])
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(params[:blog])
    @blog.author = current_user
    @activity = @blog.activity

    respond_to do |format|
      if @blog.save
        format.html { redirect_to activity_path(@activity), notice: 'Blog was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def index
    @activity = Activity.find(params[:id])
    @blogs = @activity.blogs
  end

end
