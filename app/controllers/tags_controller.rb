class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show ]

  def show
    @taggables = @tag.taggables.all.order(created_at: :desc)
    @pagy, @taggables = pagy(@taggables, items: 3)
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end
