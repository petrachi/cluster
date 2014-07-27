class HomeController < ApplicationController
  def index
    @sections = Cluster::Section.each
  end
end
