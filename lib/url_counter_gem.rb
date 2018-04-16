require 'active_record'
require 'csv'
require 'yaml'
require 'haml'
require 'url_counter_gem/url'

# A gem for counting visits to a specified URL based on exact or a regex
class UrlCounterGem
  def initialize(url, password = 'p@ssw0rd!')
    @url = url
    @password = password
    config = YAML.load_file(__dir__ + '/config/database.yml')[ENV['RAILS_ENV'] || 'development']
    ActiveRecord::Base.establish_connection config
    publish @password
  end

  def exact(url)
    increment url unless url != @url
  end

  def regex(expression)
    expression.match(@url).to_a.each do |match|
      increment match
    end
  end

  def export(location = 'data.csv')
    urls = Url.all
    File.new(location, 'w+') unless File.exist?(location)
    CSV.open(location, 'wb') do |csv|
      csv << ['url', 'visitors count', 'date']
      urls.each do |url|
        csv << [url.url, url.count, url.date]
      end
    end
  end

  def publish(location = 'output.html')
    template = File.read(__dir__ + '/templates/list.haml')
    engine = Haml::Engine.new(template)
    # sending password in plaintext is not ideal.
    # given a proper JS build it would be good to encrpyt here using digest
    # and check on other end using a crypto package for JS
    output = engine.render(Object.new, urls: Url.all, password: @password)
    puts output
    File.new(location, 'w+') unless File.exist?('output.html')
    IO.write(location, output)
  end

  private

  def increment(url)
    u = Url.where(url: url, date: DateTime.now.to_date).first_or_create
    u.count = u.count + 1
    u.save
    publish @password
  end
end
