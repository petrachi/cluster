module Cluster
  require 'cluster/bundler'
  require 'cluster/engine'
  require 'cluster/section'
  require 'cluster/version'


  def self.name= name
    @name = name
  end

  def self.name
    @name
  end

  def self.sections= sections
    @sections = sections.map{ |section| Cluster::Section.new section }
  end

  def self.sections
    @sections
  end  
end
