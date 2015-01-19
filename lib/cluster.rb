module Cluster
  if defined?(ActiveRecord)
    require 'cluster/active_record_extend'
    require 'cluster/active_record_nothing'
  end
  
  require 'cluster/bundler'
  require 'cluster/config'
  require 'cluster/engine'
  require 'cluster/section'
  require 'cluster/version'


  def configure **options
    options.each do |key, value|
      Cluster::Config.instance.send(key, value)
    end

    $cluster = Cluster::Config.instance
  end

  extend self
end
