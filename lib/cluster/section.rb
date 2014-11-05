class Cluster::Section < SimpleDelegator
  extend Enumerable

  def self.each &block
    ObjectSpace.each_object(self).map.each &block
  end

  def self.find name
    select{ |section| section === name }
  end

  def self.find_by name
    find(name).first
  end

  def self.active= name
    each{ |section| section.active = nil }
    find_by(name) && find_by(name).active = true
  end


  def initialize name
    super define_default_model(name)
    define_default_controller
  end

  def define_default_model name
    Object.const_get(name, default: Class.new(ActiveRecord::Base)).tap do |getobj|
      getobj.instance_eval do
        try_to_acts_as :decorables, :paginables, :poolables, :publishables, :taggables, :seriables
      end
    end
  end

  def define_default_controller
    Object.const_get "#{ name.pluralize }Controller", default: Class.new(ApplicationController)
  end


  alias :section :__getobj__
  attr_accessor :active

  def attributes
    ["sections-#{ self }"].tap do |attributes|
      attributes << :active if active
    end
  end

  def path view
    view.url_for section
  end

  def to_label
    name.pluralize
  end

  def to_s
    to_label.underscore
  end


  def === value
    self == value || section == value
  end
end
