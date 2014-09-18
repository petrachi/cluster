Rails.application.routes.draw do
  root 'home#index'

  Cluster::Section.each do |section|
    name = section.name.underscore

    controller name.pluralize do

      index_path = "/#{ name.pluralize }"
      index_path << "(/p/:pool)" if section.interfered? :pool

      show_path = "/#{ name }"
      show_path << if section.interfered? :tag
        "/:tag"
      else
        "/:id"
      end



      get index_path => :index, as: name.pluralize
      get show_path => :show, as: name
    end
  end
end
