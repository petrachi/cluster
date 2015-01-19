class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  if defined?(ActiveRecord)

    def index
      @collection = model_klass.collection_finder (finder_params)
      @collection = [ActiveRecordNothing.instance] if @collection.empty?
    end

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

  end


  def body_attributes
    {
      'data-action' => "#{ __class__.instance_method(action_name).owner.controller_name }##{ action_name }"
    }
  end
end
