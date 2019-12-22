class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)

  end

  def update
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment: params[:comment])
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      redirect_to @article, notice: 'Article was not updated. Try again later'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :article_id,)
    end
end
