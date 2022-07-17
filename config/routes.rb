# Первая версия

# Rails.application.routes.draw do
#   # Давайте также отобразим наш текст "Hello, Rails!"
#   # на http://localhost:3000
#   # Т.е. root соответствует чистому hostname
#   root 'articles#index'
#   get '/articles', to: 'articles#index'

#   # добавим новую вью, показывающую заголовок и содержимое отдельной статьи.
#   # добавление нового маршрута, направляющего на новый экшн контроллера
#   get "/articles/:id", to: "articles#show"  # :id - параметр маршрута.
# end

# Новая версия

# Rails предоставляет маршрутный метод resources, который связывает все общепринятые маршруты
# для коллекции ресурсов, таких как статьи. Поэтому, до того, как мы перейдем к разделам
# "C", "U" и "D", давайте заменим два маршрута get в config/routes.rb на resources

Rails.application.routes.draw do
  root 'articles#index'

  # get '/articles/new', to: 'articles#new'

  resources :articles
end
