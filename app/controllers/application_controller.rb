class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter def set_section_active
    Cluster::Section.active = _model_klass
  end


  def index
    @collection = _model_klass.all
  end


  def _model_klass
    (self.class.name.deconstantize.presence || 'Object')
      .constantize
      .const_get controller_name.singularize.camelize
  rescue NameError
    nil
  end
end
