module ActiveRecordExtend

  def collection_finder **options
    all
      .then(if: :acts_as_paginables?){ |collection| collection.paginate.page options[:page] || 1 }
      .then(if: :acts_as_poolables?){ |collection| collection.pool options[:pool] }
      .then(if: :acts_as_publishables?){ |collection| collection.published.publication_desc }
      .then(if: :acts_as_seriables?){ |collection| collection.firsts_of_series }
  end

  def instance_finder **options
    all
      .then(if: :acts_as_publishables?){ |collection| collection.published }
      .then do |collection|
        if acts_as_taggables?
          collection.tagged options[:tag]
        else
          collection.find_by id: options[:id]
        end
      end
  end


  ActiveRecord::Base.extend self
end
