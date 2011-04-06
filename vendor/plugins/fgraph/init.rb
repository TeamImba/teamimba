require 'fgraph'
require 'fgraph/rails/fgraph_helper'
require 'fgraph/rails/fgraph_tag_helper'

FGRAPH_CONFIG = "#{Rails.root.to_s}/config/fgraph.yml"

# Load configuration file
if File.exists?(FGRAPH_CONFIG)
  fgraph_config = YAML.load(ERB.new(File.read(FGRAPH_CONFIG)).result)
  FGraph.config = fgraph_config[Rails.env]
end

ActionController::Base.send :include, FGraph::Rails::FGraphHelper
ActionView::Base.send :include, FGraph::Rails::FGraphHelper
ActionView::Base.send :include,  FGraph::Rails::FGraphTagHelper