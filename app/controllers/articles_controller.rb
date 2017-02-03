class ArticlesController < ApplicationController
  before_action :set_article, only: [:update, :show, :edit, :destroy]

  def index
    @all_articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
      flash[:success] = "Article was successfully created"
    else
      render 'new'
    end
    #@article.save
    #redirect_to articles_path(@article)
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was updated successfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article deleted successfully"
    redirect_to articles_path
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :description)
    end
end