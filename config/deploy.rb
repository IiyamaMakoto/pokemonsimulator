lock '3.11.0'

set :application, 'pokemonsimulator'

set :repo_url,  'git@github.com:IiyamaMakoto/pokemonsimulator.git'

set :deploy_to, "/var/www/pokemonsimulator"

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

set :log_level, :debug

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/pokemonsimulator.pem'] 

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

before "deploy:assets:precompile", "deploy:yarn_install"
namespace :deploy do
  desc "Run rake yarn install"
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
      end
    end
  end
end

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    # invoke 'unicorn:restart'  # サービスを止めずに更新が可能、環境変数等は変更されない
    invoke 'unicorn:stop'
    invoke 'unicorn:start'      # 環境変数の修正が反映される、更新中はサービスが停止する
  end
end

set :linked_files, fetch(:linked_files, []).push("config/master.key")
append :linked_files, 'config/credentials/production.key'
