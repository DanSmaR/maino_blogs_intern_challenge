class PostsController < ApplicationController
  before_action :authenticate_user!, only: %w[new create edit update]
  before_action :get_post, only: %w[edit update destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
    @pagy, @posts = pagy(@posts, items: 3)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
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

  def edit
    # post is set in get_post method
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: t('.success')
    else
      flash.now[:alert] = t('.error')
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: t('.success')
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def get_post
    @post = current_user.posts.find(params[:id])
  end
end
