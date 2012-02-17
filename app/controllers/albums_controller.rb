class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.json

  def index
    @activity = Activity.find(params[:activity_id])
    @albums = @activity.albums
    @navi = :default
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])
    @activity = @album.imageable
    @pictures = @album.pictures
    @navi = :default

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new
    @activity = Activity.find(params[:activity_id])
    @navi = :default

    respond_to do |format|
      format.html { render "new",:layout=>false }
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])

    render :edit, :layout => false
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(params[:album])
    @activity = Activity.find(params[:activity_id])
    @album.imageable = @activity
    respond_to do |format|
      if @album.save
        format.html { redirect_to new_activity_picture_path(@activity,:album_id => @album.id), notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @activity = @album.imageable
    @album.destroy

    respond_to do |format|
      format.html { redirect_to activity_albums_path(@activity) }
      format.json { head :ok }
    end
  end
end
