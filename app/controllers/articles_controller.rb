class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  # Экшн new инициализирует новую статью, но не сохраняет ее. Эта статья будет
  # использована во вью при построении формы. По умолчанию экшн new будет
  # рендерить app/views/articles/new.html.erb, которую мы создадим далее.

  # При посещении http://localhost:3000/articles/new, запрос GET /articles/new
  # направляется на экшн new. Экшн new не пытается сохранить @article.
  # Следовательно,валидации не проверяются, и сообщений об ошибке не будет.
  def new
    @article = Article.new
  end

  # Отправленные данные формы вкладываются в хэш params, вместе с
  # захваченными параметрами маршрута. Таким образом, экшн create имеет
  # доступ к отправленному заголовку как params[:article][:title] и к
  # отправленному содержимому как params[:article][:body]

  # При отправке формы, запрос POST /articles направляется на экшн create.
  # Экшн create пытается сохранить @article. Следовательно, валидации проверяются.
  # Если любая из валидаций падает, @article не будет сохранена, и
  # app/views/articles/new.html.erb будет отрендерена с сообщением об ошибке....
  def create
    # не вполне понимаю - откуда здесь параметры
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end
end




# Старая версия
# def create
#   @article = Article.new(title: "...", body: "...")

#   if @article.save
#     redirect_to @article
#   else
#     render :new, status: :unprocessable_entity
#   end
# end

# Недопонимаю логику
# article = Article.new - создает новый объект формы Article - пустой ?
