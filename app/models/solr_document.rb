# -*- encoding : utf-8 -*-
class SolrDocument

  include Blacklight::Solr::Document
  # The following shows how to setup this blacklight document to display marc documents
  extension_parameters[:marc_source_field] = :marc_display
  extension_parameters[:marc_format_type] = :marcxml
  use_extension(Blacklight::Solr::Document::Marc) do |document|
    document.key?(:marc_display)
  end

  field_semantics.merge!(
      :title => "mods_titleInfo_usage_primary_title_ms",
      :author => "author_display",
      :language => "language_facet",
      :format => "format"
  )


  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  def viewer_url
    _source['mods_identifier_type_uri_ms'][0]
  end

  def has_finding_aid?
    !_source['mods_relatedItem_type_host_findingAid_ms'].blank?
  end

  def finding_aid_url
    _source['mods_relatedItem_type_host_findingAid_ms'][0]
  end

  # Are there more images than just the thumbnail?
  def more_images?
    plurals_in_description? || has_id_range?
  end

  private

  # Are there indicative plurals in the item description?
  def plurals_in_description?
    description = _source['mods_physicalDescription_extent_ms']
    plurals = %w(negatives images surrogates leaves pages letter manuscript)
    if description.length > 0
      description = description[0]
    end
    description =~ /#{plurals.join('|')}/
  end

  # Is there range of item identifiers or just one?
  def has_id_range?
    if _source['mods_holdingSimple_copyInformation_itemIdentifier_type_local_ms']
      id_range_has_multiple_ids?
    else
      false
    end
  end

  def id_range_has_multiple_ids?
    item_id_array = _source['mods_holdingSimple_copyInformation_itemIdentifier_type_local_ms']
    if item_id_array.length > 0
      item_id_strings = item_id_array[0].split('-')
    else
      item_id_strings = item_id_array.split('-')
    end

    if item_id_strings.length == 2 && item_id_strings[1] != item_id_strings[0]
      true
    else
      false
    end
  end

end
