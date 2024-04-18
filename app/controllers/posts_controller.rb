class PostsController < ApplicationController
  before_action :authenticate_user!, only: %w[new create]

  def index
    @posts = Post.all.order(created_at: :desc)
    @pagy, @posts = pagy(@posts, items: 3)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: t('.success')
    else
      flash.now[:alert] = t('.error')
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
