# rails-auth-app

## このアプリケーションについて

Railsを使用して認証機能を作成するためのテストアプリです

## デモ


## 使い方


## 環境

auth-appを使用するための環境要件は以下の通りです

- OS: macOS
- 言語: Ruby 3.0.2、Rails 7.1.3.2
- パッケージ管理ツール:Homebew
- データベース：　PostgreSQL

### 環境構築
```
# Homebewを最新化する
$ brew update

# 利用可能なRubyのバージョンを確認する
$ rbenv install -l

# 指定のバージョンのRubyをインストールする
$ rbenv install 3.0.2

# デフォルトのRubyを設定する
$ rbenv global 3.0.2

# Bundlerをインストールする
$ gem install bundler

# Railsをインストールする
$ gem install rails
```


### ローカルでの動作確認をする
```
# Railsプロジェクトを作成する
$ rails new rails_auth_app

# Railsプロジェクトに移動する
$ cd rails_auth_app

# Railsプロジェクトを起動する
$ rails server

# http://localhost:3000/ にアクセスし、初期画面が表示されればOK

```


### 本番環境用のPostgreSQLを使うための準備をする
```
# PostgreSQLをインストールする
$ brew install postgresql
$ postgres --version
psql (PostgreSQL) 14.11 (Homebrew)

# PostgreSQLセットアップする
$ brew services start postgresql
# ※停止
$ brew services stop postgresql

# ユーザー設定をする（PostgreSQLを立ち上げた状態で行う）
$ createuser -s -P <ユーザー名>
Enter password for new role: <パスワードを設定>
Enter it again: <サイドパスワードを入力>

# Gemfileを編集する
group :development, :test do
   gem 'sqlite3
end

group :production do
  gem 'pg'
  # 環境変数の設定
  gem 'dotenv-rails'
end

# bundle installをする
bundle install --without test development

# config/database.ymlを編集する
production:
  adapter: postgresql
  encoding: unicode
  pool:  <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  database: <任意のデータベース名>
  username: <任意のユーザー名>
  password: <%= ENV['DB_PASSWORD'] %> # .envで設定

# DBを構築する
$ db:create RAILS_ENV=production
$ db:migrate RAILS_ENV=production
$ db:seed RAILS_ENV=production

# 本番環境用にassets:precompileする
#　このままrails s -e productionを実行してもスタイルがちゃんと読み込まれない。
$ assets:precompile RAILS_ENV=production
```

## 使用した技術

- Auth0(認証機能のためのサービス)
- Render(デプロイするためのサービス) 

## 参考文献

- 参考情報
