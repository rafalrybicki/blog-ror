class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @categories = Category.all
    @articles = Article.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 9)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  def search
    @categories = Category.all
    if params[:user]
      @username = User.find(params[:user]).username
      @articles = Article.where(user: params[:user]).order(created_at: :desc).paginate(:page => params[:page], :per_page => 9)
    elsif params[:category]
      @articles = Article.where(category_id: params[:category]).order(created_at: :desc).paginate(:page => params[:page], :per_page => 9)
    else
      @articles = Article.search(params).paginate(:page => params[:page], :per_page => 9)
    end

  end

  def all
    if current_user.admin
      @articles = Article.all.order(created_at: :desc)
    else
      @articles = Article.where(user: current_user.id)
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      redirect_to @article, info: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, success: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
      redirect_to root_path, info: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :user_id, :category_id, :image)
    end
end
