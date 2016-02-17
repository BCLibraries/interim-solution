module CollectionsHelper

  # Get highlighted collections from JSON file for front-page display.
  def highlighted_collections
    if Rails.env.staging?
      load_collections
    else
      @highlighted_collections ||= load_collections
    end
  end

  def load_collections
    JSON.parse(File.read('config/collections.json'))
  end

  def text_link_to_collection(collection)
    url = collection_url collection
    link_to collection['title'], url
  end

  def image_link_to_collection(collection)
    url = collection_url collection
    image = image_tag collection['img'], alt: collection['title'], class: collection['layout']
    link_to image, url
  end

  def collection_url(collection)

    # Facet matches must be exact. Some collections need near-matches.
    if collection['facet_val']
      "/?f%5Bmods_relatedItem_type_host_collectionFacet_ms%5D%5B%5D=#{collection['facet_val']}"
    else
      "/?f%5Bmods_relatedItem_type_host_collection_ms%5D%5B%5D=#{collection['non_facet_val']}"
    end
  end
end
