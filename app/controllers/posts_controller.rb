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
    unless params[:post].present?
      @post = current_user.posts.build
      redirect_to new_post_path, alert: t('.no_file')
      return
    end

    if params[:post][:file].present?
      uploaded_file = params[:post][:file]
      file_content = File.open(uploaded_file.tempfile, "r:UTF-8").read

      parsed_content = valid_file_format?(uploaded_file, file_content)

      unless parsed_content
        @post = current_user.posts.build(post_params.except(:tags, :file))
        @post.errors.add(:base, t('.invalid_file_format'))
        flash.now[:alert] = t('.error')
        render 'new', status: :unprocessable_entity
        return
      end

      params[:post][:title] = parsed_content[:title]
      params[:post][:content] = parsed_content[:content]
      params[:post][:tags] = parsed_content[:tags]
    end

    @post = current_user.posts.build(post_params.except(:tags, :file))

    if @post.save
      associate_tags_to_post(@post, params[:post][:tags])
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
    associate_tags_to_post(@post, params[:post][:tags])
    if @post.update(post_params.except(:tags))
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
      params.require(:post).permit(:title, :content, :tags, :file)
    end

    def get_post
      @post = current_user.posts.find(params[:id])
    end

    def associate_tags_to_post(post, tags)
      post.taggables.destroy_all
      tags = tags.strip.gsub(' ', '').split(',').reject {|el| el == ''}
      tags.each do |tag|
        post.tags << Tag.find_or_create_by(name: tag)
      end
    end

  def valid_file_format?(uploaded_file, file_content)
    return false unless uploaded_file.content_type == 'text/plain'

    lines = file_content.split("\n")

    title = lines[0]
    content = lines[1..-2].join("\n")

    unless title.present? && content.present?
      return false
    end

    { title: title, content: content, tags: lines.last }
  end
end
