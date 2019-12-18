# Commands sheetcheat 

```
rails _6.0.1_ new annotable_app --api \
  --database=postgresql \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-puma \
  --skip-action-cable \
  --skip-sprockets \
  --skip-javascript \
  --skip-turbolinks \
  --skip-test \
  --skip-webpack-install
```

```  
# Add User
createuser -D -A -P annotable
# psql template1
alter role annotable with superuser;
```

Change Gemfile 

```
# gem 'rails', '~> 6.0.1'

gem 'actionpack', '~> 6.0.1'
gem 'activemodel', '~> 6.0.1'
gem 'activerecord', '~> 6.0.1'
gem 'activesupport', '~> 6.0.1'
gem 'activejob', '~> 6.0.1'
gem 'activestorage', '~> 6.0.1'
gem 'railties', '~> 6.0.1'
```

bin/rails middleware

```
# config/application.rb

config.middleware.delete ActionDispatch::Cookies
config.middleware.delete Rack::Sendfile
config.middleware.delete ActionDispatch::Static
config.middleware.delete ActiveSupport::Cache::Strategy::LocalCache::Middleware
config.middleware.delete ActionDispatch::ActionableExceptions
config.middleware.delete ActionDispatch::Callbacks

git add . && git commit -m 'Lightweight Dependencies'
```

Log autoload 

```
echo 'Rails.autoloaders.logger = Rails.logger' > config/initializers/autoloader.rb

git add . && git commit -m 'Log Autoloader Activities'
```

Add Rspec 

```
gem 'rspec-rails'

mkdir spec/support
touch spec/support/.keep

bin/rails generate rspec:install

git add . && git commit -m 'Add RSpec'
```

Add Database Cleaner

```
# Database Cleaner is not needed in Rails Console
group :test do
  # ...
  gem 'database_cleaner'
end

git add . && git commit -m 'DatabaseCleaner'
```

Add Fixture 

```
# Make convenient to use in Rails Console
group :development, :test do
  # ...
  gem 'ffaker'
  gem 'factory_bot_rails'
end

mkdir spec/factories
touch spec/factories/.keep

git add . && git commit -m 'FactoryGirl And FFaker'
```

Add Organization model

```
bin/rails generate scaffold organization name:string

git add . && git commit -m 'Add Organization Scaffold'
```

Just subtle changed are needed to make that works

```
git add . && git commit -m 'Set Organization Properly'
```

Add set of data

```
in db/seeds.rb

require 'ffaker'

5.times.each do
  organization = FactoryBot.create(:organization)
  puts("Create Organization #{organization.name}")
end
```

migrate data 

```
bin/rails db:create && \
bin/rails db:migrate && \
bin/rails db:seed
```

```
bin/rails server
```

```
curl -X GET http://localhost:3000/organizations | python -mjson.tool

[
    {
        "created_at": "2019-12-12T15:28:09.630Z",
        "id": 1,
        "name": "Hahn, Daugherty and Harris",
        "updated_at": "2019-12-12T15:28:09.630Z"
    },
    {
        "created_at": "2019-12-12T15:28:09.635Z",
        "id": 2,
        "name": "Block LLC",
        "updated_at": "2019-12-12T15:28:09.635Z"
    },
    {
        "created_at": "2019-12-12T15:28:09.638Z",
        "id": 3,
        "name": "Wintheiser Inc",
        "updated_at": "2019-12-12T15:28:09.638Z"
    },
    {
        "created_at": "2019-12-12T15:28:09.641Z",
        "id": 4,
        "name": "Hermann Inc",
        "updated_at": "2019-12-12T15:28:09.641Z"
    },
    {
        "created_at": "2019-12-12T15:28:09.644Z",
        "id": 5,
        "name": "Hamill-Prosacco",
        "updated_at": "2019-12-12T15:28:09.644Z"
    }
]
```

```
bin/rails generate scaffold user name:string email:string organization:references

git add . && git commit -m 'Add User Scaffold'
```

Just subtle changed are needed to make that works

```
git add . && git commit -m 'Set User Properly'
```

```
bin/rails db:migrate
```

```
curl -X GET http://localhost:3000/users | python -mjson.tool
```

```
bin/rails generate scaffold project name:string organization:references

git add . && git commit -m 'Add Project Scaffold'
```

Just subtle changed are needed to make that works

```
git add . && git commit -m 'Set Project Properly'
```

```
curl -X GET http://localhost:3000/organizations/17/projects | python -mjson.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   702  100   702    0     0   3078      0 --:--:-- --:--:-- --:--:--  3065
[
    {
        "created_at": "2019-12-13T09:44:49.782Z",
        "id": 26,
        "name": "Becker and Sons",
        "organization_id": 17,
        "updated_at": "2019-12-13T09:44:49.782Z"
    },
    {
        "created_at": "2019-12-13T09:44:49.787Z",
        "id": 27,
        "name": "Padberg, Ernser and Wolf",
        "organization_id": 17,
        "updated_at": "2019-12-13T09:44:49.787Z"
    },
    {
        "created_at": "2019-12-13T09:44:49.792Z",
        "id": 28,
        "name": "Trantow, Bogisich and Mitchell",
        "organization_id": 17,
        "updated_at": "2019-12-13T09:44:49.792Z"
    },
    {
        "created_at": "2019-12-13T09:44:49.795Z",
        "id": 29,
        "name": "Wilderman-Kreiger",
        "organization_id": 17,
        "updated_at": "2019-12-13T09:44:49.795Z"
    },
    {
        "created_at": "2019-12-13T09:44:49.799Z",
        "id": 30,
        "name": "Hamill Inc",
        "organization_id": 17,
        "updated_at": "2019-12-13T09:44:49.799Z"
    }
```

```
bin/rails generate scaffold report name:string content:text project:references

git add . && git commit -m 'Add Report Scaffold'
```

Just subtle changed are needed to make that works

```
git add . && git commit -m 'Set Report Properly'
```

```
curl -X GET http://localhost:3000/organizations/27/projects/76/reports | python -mjson.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1710  100  1710    0     0   7184      0 --:--:-- --:--:-- --:--:--  7184
[
    {
        "content": "Similique ut illo itaque labore quis voluptate cumque tempore. Ut maxime dignissimos quis qui quas earum sed. Quisquam sit ipsam vel assumenda qui vel dolores.",
        "created_at": "2019-12-13T10:28:35.217Z",
        "id": 130,
        "name": "Power Disc Lifter",
        "project_id": 76,
        "updated_at": "2019-12-13T10:28:35.217Z"
    },
    {
        "content": "Est suscipit vitae dolore non ullam quam deserunt possimus. Aut voluptas voluptatibus saepe qui quo labore fugit sunt. Et numquam id aliquam possimus doloribus nam soluta. Alias et voluptates accusamus cumque ad sapiente. Qui dolore dicta consequatur tenetur voluptas esse.",
        "created_at": "2019-12-13T10:28:35.213Z",
        "id": 129,
        "name": "Gel Air Component",
        "project_id": 76,
        "updated_at": "2019-12-13T10:28:35.213Z"
    },
    {
        "content": "Nihil fugiat praesentium ratione ut eos veritatis enim. Inventore mollitia dicta error ratione id. Porro recusandae corporis sapiente eius. Temporibus dolorem quasi quos et assumenda qui. Quis mollitia sit quia quo.",
        "created_at": "2019-12-13T10:28:35.209Z",
        "id": 128,
        "name": "Audible Compressor",
        "project_id": 76,
        "updated_at": "2019-12-13T10:28:35.209Z"
    },
    {
        "content": "Possimus totam cum ut sed et doloribus numquam id. Blanditiis mollitia unde quis sit quae ut facilis consectetur. Asperiores sit sed omnis similique odio nihil officiis enim.",
        "created_at": "2019-12-13T10:28:35.205Z",
        "id": 127,
        "name": "GPS Bracket",
        "project_id": 76,
        "updated_at": "2019-12-13T10:28:35.205Z"
    },
    {
        "content": "Non qui nihil velit quia molestiae unde qui. Eos aliquam mollitia illum molestiae fuga dolore. Velit necessitatibus laudantium enim aperiam in voluptas accusamus.",
        "created_at": "2019-12-13T10:28:35.200Z",
        "id": 126,
        "name": "Portable Case",
        "project_id": 76,
        "updated_at": "2019-12-13T10:28:35.200Z"
    }
]
```

```
bin/rails generate scaffold note title:string content:text report:references

git add . && git commit -m 'Add Note Scaffold'
```

Just subtle changed are needed to make that works

```
git add . && git commit -m 'Set Note Properly'
```

```
curl -X GET http://localhost:3000/organizations/32/projects/101/reports/251/notes | python -mjson.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   994  100   994    0     0   3928      0 --:--:-- --:--:-- --:--:--  3928
[
    {
        "content": "Et natus odio voluptates dolor ratione maiores.",
        "created_at": "2019-12-13T10:41:38.808Z",
        "id": 5,
        "report_id": 251,
        "title": "solutaliberodoloremque",
        "updated_at": "2019-12-13T10:41:38.808Z"
    },
    {
        "content": "Ut molestias omnis magnam rerum blanditiis consequatur quae.",
        "created_at": "2019-12-13T10:41:38.805Z",
        "id": 4,
        "report_id": 251,
        "title": "liberoblanditiisdolorem",
        "updated_at": "2019-12-13T10:41:38.805Z"
    },
    {
        "content": "Culpa non atque porro voluptatem quos tempore.",
        "created_at": "2019-12-13T10:41:38.801Z",
        "id": 3,
        "report_id": 251,
        "title": "etnobisipsum",
        "updated_at": "2019-12-13T10:41:38.801Z"
    },
    {
        "content": "Et dolores omnis rerum minus.",
        "created_at": "2019-12-13T10:41:38.798Z",
        "id": 2,
        "report_id": 251,
        "title": "eligendiistea",
        "updated_at": "2019-12-13T10:41:38.798Z"
    },
    {
        "content": "Rerum voluptas ut laboriosam laudantium qui qui saepe doloremque.",
        "created_at": "2019-12-13T10:41:38.793Z",
        "id": 1,
        "report_id": 251,
        "title": "exercitationemvoluptatumdolorem",
        "updated_at": "2019-12-13T10:41:38.793Z"
    }
]
```

```
gem 'spring-commands-rspec'

bundle exec spring binstub rspec

bin/rspec

git add . && git commit -m 'Add Rspec to Spring'
```

```
# config/application.rb

config.active_record.schema_format = :sql
```

```
bin/rails db:structure:dump
```

```
git rm db/schema.rb
```

```
git add . && git commit -m 'Switch to Structure.sql'
```

# Pluging Rails Engine on

```
gem 'annotable', path: '../annotable'
```

```
mount Annotable::Engine, at: 'v1'
```

```
bin/rails railties:install:migrations
```
```
bin/rails db:migrate SCOPE=annotable
```

```
mkdir tmp/dumps
pg_dump -d annotable_app_development -U annotable -Fc -f tmp/dumps/annotable_app_development_before_engine.dump
```

```
pg_restore \
--verbose \
--clean \
--jobs=4 \
--disable-triggers \
--no-acl \
--no-owner -h localhost -U annotable -d annotable_app_development tmp/dumps/annotable_app_development_before_engine.dump
```

