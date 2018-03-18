class PostsController < ApplicationController
  def index
    render json: {success: :ok, status: 200}
  end

  def create
    render json: {success: :ok, status: 200}
  end

end
