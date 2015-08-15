#!/bin/bash
if [ -z "$MONGODB_URL" ]; then
  export MONGODB_URL="mongodb://mongodb/errbit"
fi
export PATH=/opt/ruby/bin:$PATH
if [ -z "$SECRET_TOKEN" -a ! -f "config/initializers/__secret_token.rb" ]; then
  echo "Errbit::Application.config.secret_token = '$(bundle exec rake secret)'" > config/initializers/__secret_token.rb
fi
if [ "$1" == "web" ]; then
  bundle exec unicorn -p 3000 -c ./config/unicorn.default.rb
elif [ "$1" == "seed" ]; then
  bundle exec rake errbit:bootstrap
elif [ "$1" == "upgrade" ]; then
  bundle exec rake db:migrate
  bundle exec rake db:mongoid:create_indexes
  bundle exec rake db:mongoid:remove_undefined_indexes
else
  bundle exec "$@"
fi
