git clone https://github.com/vladilav007/vanilla_ruby.git
cd delivery_app
bundle install
yarn install
rails db:migrate
rails db:seed
rails s
