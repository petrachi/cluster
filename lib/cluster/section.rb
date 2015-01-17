class Cluster::Section

  attr_accessor :model

  def initialize name
    @model = define_default_model(name)
    define_default_decorator
    define_default_controller
  end

  delegate :name, to: :model

  def define_default_model name
    Object.const_get(name, default: Class.new(ActiveRecord::Base)).tap do |getobj|
      getobj.instance_eval do
        try_to_acts_as :decorables, :paginables, :publishables, :taggables, :seriables
      end
    end
  end

  def define_default_decorator
    Object.const_get(name).decorator_class.class_eval do
      def url
        view.url_for(self)
      end
    end
  end

  def define_default_controller
    Object.const_get "#{ name.pluralize }Controller", default: Class.new(ApplicationController)
  end


  def path view
    view.url_for model
  end

  def to_label
    name.pluralize
  end

  def to_s
    to_label.underscore
  end
end
