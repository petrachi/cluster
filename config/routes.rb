Rails.application.routes.draw do
  root 'home#index'

  Cluster::Section.each do |section|
    name = section.name.underscore

    controller name.pluralize do

      collection_path = "/#{ name.pluralize }"
      collection_path << "(/p/:pool)" if section.acts_as_poolables?
      collection_path << "(/s/:series)" if section.acts_as_seriables?
      collection_path << "(/n/:page)" if section.acts_as_paginables?

      instance_path = "/#{ name }"
      instance_path << if section.acts_as_taggables?
        "/:tag"
      else
        "/:id"
      end



      get collection_path => :index, as: name.pluralize
      get instance_path => :show, as: name
    end
  end
end
