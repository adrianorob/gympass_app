# Gympass app - Adriano Wiermann

Aplicativo teste criado para equipe técnica do Gympass utilizar para avaliação.

## Configurações

* Ruby version (gympass_app/.ruby-version) - 2.3.1
* Rails - 5.0.0.1
* PostgreSQL 9.5.3
* User registrations - Devise
* Users tokens - Tokens
* Geocoder
* Gmaps4rails

## Instalar o sistema

```bash
git clone https://github.com/adrianorob/gympass_app.git
cd gympass_app

bundle install

rails db:create
rails db:migrate
```

## Inserindo dados

Para parecer mais realista foi criado um seed.rb para popular dados de academias do Gympass.

É preciso duas livrarias ruby:
```bash
gem install 'nokogiri'
gem install 'open-uri'
```
* Primeiro usuario:
```ruby
user = User.create!(name: 'Xará',
                    email: 'adriano@gympass.com',
                    type_user: '0',
                    work_address: 'Sao Paulo',
                    password: "123123",
                    password_confirmation: "123123",
                    admin: "true"
                    )
```
* Inicia o comando para popular:
```bash
rails db:seed
```

## Iniciar o servidor

Após esses primeiros passos pode-se iniciar o servidor e navegar pela aplicação.

```bash
rails server
```
