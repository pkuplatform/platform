class ChannelsController < ApplicationController
  before_filter :authenticate_user!

  def create
    Channel.create!(params)
    head :ok
  end

  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
    head :ok
  end
end
