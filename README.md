### TeachBaseBot
###### Оповещения в Slack
- Скачать репозиторий на свой сервер
- Установить гемы с помощью `bundle install`
- Создать бота Slack и скопировать его `Bot User OAuth Access Token`
- Добавить его на канал в котором будут уведомления `/invite НАЗВАНИЕ_БОТА` (в канале Slack)
- Настроить `config.rb` (там все очень просто, есть пример)
- Что бы добавить задачу в crontab, запустить `ruby init.rb`
- Каждые 5 минут будут проверяться курсы на наличие новых ответов



###### Если будет проблема c Ruby при установке гемов, удалите Gemfile.lock
