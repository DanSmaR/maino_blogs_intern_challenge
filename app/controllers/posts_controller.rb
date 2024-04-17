class PostsController < ApplicationController
  before_action :authenticate_user!, only: %w[new create]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def create
  end

  def new
  end
end
