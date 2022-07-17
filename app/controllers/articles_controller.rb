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

  # извлекает статью из базы данных и сохраняет ее в @article, таким образом ее
  # можно использовать при построении формы. По умолчанию экшн edit отрендерит
  # app/views/articles/edit.html.erb
  def edit
    @article = Article.find(params[:id])
  end

  # (пере)извлекает статью из базы данных и пытается обновить ее с помощью
  # отправленных данных формы, фильтрованных в article_params. Если ни одна
  # валидация не упадет, и обновление будет успешным, этот экшн перенаправит браузер
  # на страницу статьи.
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Удаление ресурса это более простой процесс, чем создание или обновление.
  # Он требует только маршрут и экшн контроллера. И наш ресурсный роутинг
  # (resources :articles) уже предоставляет этот маршрут, связывающий запросы
  # DELETE /articles/:id с экшном destroy в ArticlesController

  # Экшн destroy извлекает статью из базы данных, и вызывает destroy на ней.
  # Затем он перенаправляет браузер на корневой путь.

  # Мы выбрали перенаправление на корневой путь, так как это наша основная точка
  # доступа к статьям. В других обстоятельствах можно было бы выбрать
  # перенаправление на articles_path.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
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
