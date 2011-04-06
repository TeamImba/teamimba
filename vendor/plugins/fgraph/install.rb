require 'rubygems'
require 'fileutils'

fgraph_config = File.join(Rails.root, "config", "fgraph.yml")
unless File.exist?(fgraph_config)
  fgraph_config_template = File.join(Rails.root, "vendor", "plugins", "fgraph", "templates", "fgraph.yml")
  FileUtils.cp fgraph_config_template, fgraph_config
  puts "#{Rails.root}/config/fgraph.yml created, please update your app_id and app_secret."
end