Rails.application.routes.draw do
  root 'home#index'

  $cluster.models.each do |model|
    name = model.name.underscore

    controller name.pluralize do

      collection_path = "/#{ name.pluralize }"
      collection_path << "(/s/:series)" if model.acts_as_seriables?
      collection_path << "(/p/:page)" if model.acts_as_paginables?
      collection_path << "(/o/:pool)" if model.acts_as_poolables?

      instance_path = "/#{ name }"
      instance_path << if model.acts_as_taggables?
        "/:tag"
      else
        "/:id"
      end


      get collection_path => :index, as: name.pluralize
      get instance_path => :show, as: name
    end
  end
end
