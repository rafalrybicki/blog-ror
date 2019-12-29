class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.create(comment_params)
    redirect_to @article
  end

  def update
    # @comment = Comment.find(params[:id])
    # if @comment.update(comment_params)
    #   redirect_to @article, notice: 'Article was successfully updated.'
    # else
    #   redirect_to @article, notice: 'Article was not updated. Try again later'
    # end
    @comment = Comment.find(params[:id])
    if @comment.update(content: params[:content])
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      redirect_to @article, notice: 'Article was not updated. Try again later'
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :article_id, :user_id)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end
end
