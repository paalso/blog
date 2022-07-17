class Article < ApplicationRecord
  # добавим некоторые валидации в нашу модель в app/models/article.rb
  # которые будут проверяться при создании новой article?
  # кстати, при создании новой article в консоли не проверяются
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end