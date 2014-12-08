class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter def set_section_active
    Cluster::Section.active = model_klass
  end


  def index
    @collection = model_klass.collection_finder finder_params
  end

  # TODO: dans les articles ..., faire un pouce vert/pouce rouger
  # de base, c'est juste un graph de répartition, sur une ligne "+++--"(60%)
  # mais quand on passe la souris dessus, ça se transforme en graph à barre, le graph 1d, passe en 2d
  # "+++   "
  # "+++ --"
  # "+++ --" (60%)

  def show
    @obj = model_klass.instance_finder finder_params
  end


  private def model_klass
    __class__.namespace.const_get controller_name.classify
  rescue NameError
    nil
  end

  private def finder_params
    params.permit(%i{id page pool series tag}).symbolize_keys
  end
end
