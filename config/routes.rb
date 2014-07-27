Rails.application.routes.draw do
  root 'home#index'

  Cluster::Section.each do |section|
    name = section.name.underscore

    controller name.pluralize do
      get "/#{ name.pluralize }" => :index, as: name.pluralize
      get "/#{ name }/:tag" => :show, as: name
    end
  end
end
