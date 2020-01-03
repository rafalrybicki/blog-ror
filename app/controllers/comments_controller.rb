class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  def edit
    @comment = @article.comments.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :article_id, :user_id)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end
end
