class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.build(comment_params)

    if comment.save
      redirect_to @post, notice: t('.success')
    else
      redirect_to @post, alert: t('.error')
    end
  end

  private

  def comment_params
    comment_params = params.require(:comment).permit(:message)
    comment_params[:user_id] = get_user.id
    comment_params
  end

  def get_user
    if user_signed_in?
      user = current_user
    else
      user = User.find_by(email: 'anonimo@email.com')
      unless user
        user = User.create(name: 'Anônimo', email: 'anonimo@email.com', password: 123456)
      end
    end
    user
  end
end
