class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @collection = model_klass.collection_finder (finder_params)
    @collection = [ActiveRecordNothing.instance] if @collection.empty?
  end

  # TODO: dans les articles ..., faire un pouce vert/pouce rouger
  # de base, c'est juste un graph de répartition, sur une ligne "+++--"(60%)
  # mais quand on passe la souris dessus, ça se transforme en graph à barre, le graph 1d, passe en 2d
  # "+++   "
  # "+++ --"
  # "+++ --" (60%)

  def show
    @object = model_klass.instance_finder finder_params
    @object = ActiveRecordNothing.instance if @object.blank?
  end


  protected def model_klass
    __class__.namespace.const_get controller_name.classify
  rescue NameError
    nil
  end

  protected def finder_params
    params.permit(%i{id page pool series tag}).symbolize_keys
  end


  def body_attributes
    {
      'data-action' => "#{ __class__.instance_method(action_name).owner.controller_name }##{ action_name }"
    }
  end
end
