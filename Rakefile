require 'active_record'
require 'yaml'

namespace :counter do
  desc "Initialize the `urls` table in the DB"
  task :init do
    config = YAML.load_file(__dir__ + '/lib/config/database.yml')[ENV["RAILS_ENV"] || "development"]
    
    ActiveRecord::Base.establish_connection config
    next if ActiveRecord::Base.connection.table_exists? 'urls'

    ActiveRecord::Migration.class_eval do
      create_table :urls do |t|
        t.string  :url
        t.integer :count, default: 0
        t.date :date
      end
    end
  end
end 
