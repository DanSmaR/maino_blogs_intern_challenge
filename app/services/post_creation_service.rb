class PostCreationService
  def initialize(user, post_params)
    @user = user
    @post_params = post_params
  end

  def call
    post = @user.posts.build(@post_params.except(:tags, :file))

    if post.save
      post.associate_tags(@post_params[:tags])
    end

    post
  end
end