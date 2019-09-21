require_relative 'boot'

require 'rails/all'
require_relative('../app/models/article.rb')

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Planetocd
  class Application < Rails::Application
    attr_accessor :articles
    @articles

    def load_articles(path)
      @articles = Hash.new
      to_convert = Dir.glob("#{path}/*.mdocd")
      to_convert.each do |article_path|
        mdocd_content = IO.read(article_path)
        article = Article.new(mdocd_content)
        @articles[article.title] = article
      end
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    load_articles(Rails.root.join('app', 'assets', 'articles'))
  end
end
