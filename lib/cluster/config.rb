class Cluster::Config
  include Singleton

  def name
    Rails.application.class.parent_name.titleize.upcase
  end

  def sections sections = nil
    if sections
      @sections = sections.map{ |section| Cluster::Section.new section }
    else
      @sections || []
    end
  end

  def models
    sections.map(&:model)
  end
end
