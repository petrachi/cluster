class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter def set_section_active
    Cluster::Section.active = model_klass
  end


  def index
    @collection = model_klass.collection_finder finder_params
  end

  def show
    @obj = model_klass.instance_finder finder_params
  end


  private
  def model_klass
    __namespace__.const_get controller_name.classify
  rescue NameError
    nil
  end

  def finder_params
    params.permit(%i{id pool series tag}).symbolize_keys
  end
end
