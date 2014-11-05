class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter def set_section_active
    Cluster::Section.active = model_klass
  end


  def index
    @collection = model_klass.collection_finder finder_params

    if @collection.acts_as_paginables?
      params[:page] ||= 1
      @collection = @collection.paginate.page(params[:page].to_i).per_page(2)
    end

    @collection
  end

  def show
    @obj = model_klass.instance_finder finder_params
  end


  private
  def model_klass
    __class__.namespace.const_get controller_name.classify
  rescue NameError
    nil
  end

  def finder_params
    params.permit(%i{id pool series tag}).symbolize_keys
  end
end
