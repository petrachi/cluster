class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter def set_section_active
    Cluster::Section.active = model_klass
  end


  def index
    @collection = model_klass.all
  end

  def show
    @obj = model_klass.tagged params[:tag]
  end


  private
  def model_klass
    (self.class.name.deconstantize.presence || 'Object')
      .constantize
      .const_get controller_name.classify
  rescue NameError
    nil
  end
end
