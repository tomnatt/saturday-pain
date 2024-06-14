require 'jekyll'
require './lib/image_manager'

task default: [:clean] do
  Jekyll::Commands::Build.process({ config: '_config/jekyll_config.yml' })
end

desc 'Run Jekyll server'
task :serve do
  # Jekyll::Commands::Serve.process({ config: '_config/jekyll_config.yml' })
  system 'bundle exec jekyll serve --config _config/jekyll_config.yml --incremental'
end

desc 'Delete generated files, including images'
task :clean do
  Jekyll::Commands::Clean.process({ config: '_config/jekyll_config.yml' })
end

desc 'Delete all downloaded images and metadata'
task :delete_images do
  ImageManager.delete_all
end

desc 'Download all images and metadata'
task :download_images do
  ImageManager.download_images
end
