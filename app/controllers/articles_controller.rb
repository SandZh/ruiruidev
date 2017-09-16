class ArticlesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_article_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit

  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def update


    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
  

    @article.destroy
    redirect_to articles_path
  end


  private

  def find_article_and_check_permission
    @article = Article.find(params[:id])

    if current_user != @article.user
      redirect_to articles_path, alert: "You have no permission."
    end
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
