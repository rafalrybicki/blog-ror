class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.create(comment_params)
    @comment.save
    # respond_to do |format|
    #   if @comment.save
    #     format.html { redirect_to @article }
    #     format.js
    #     format.json { render json: @comment, status: :created, location: @article }
    #   else
    #     format.html { render :new }
    #   end
    # end
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

    respond_to do |format|
      format.js
      format.html { redirect_to root_path, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :article_id, :user_id)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end
end
