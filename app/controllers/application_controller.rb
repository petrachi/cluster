class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def index
    @collection = _model_klass.all
  end


  def _model_klass
    (self.class.name.deconstantize.presence || "Object")
      .constantize
      .const_get controller_name.singularize.camelize
  end
end
