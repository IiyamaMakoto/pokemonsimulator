# config valid for current version and patch releases of Capistrano
lock "3.12.0"

set :application, "pokemonsimulator"
set :repo_url, "git@github.com:IiyamaMakoto/pokemonsimulator.git"

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/pokemonsimulator.pem'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    # invoke 'unicorn:restart'  # サービスを止めずに更新が可能、環境変数等は変更されない
    invoke 'unicorn:stop'
    invoke 'unicorn:start'      # 環境変数の修正が反映される、更新中はサービスが停止する
  end
end

set :linked_files, fetch(:linked_files, []).push("config/master.key")