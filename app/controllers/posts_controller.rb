class PostsController < ApplicationController
  before_action :authenticate_user!, only: %w[new create]

  def index
    @posts = Post.all.order(created_at: :desc)
    @pagy, @posts = pagy(@posts, items: 3)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
  end

  def new
  end
end
