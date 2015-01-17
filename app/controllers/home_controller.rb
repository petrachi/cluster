class HomeController < ApplicationController
  def index
    @sections = $cluster.sections
  end
end
