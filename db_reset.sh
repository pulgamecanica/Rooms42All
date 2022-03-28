heroku run rails db:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1
heroku run rails db:load
heroku run rails db:migrate
heroku run rails db:seed
