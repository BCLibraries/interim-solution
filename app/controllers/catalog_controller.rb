# -*- encoding : utf-8 -*-
class CatalogController < ApplicationController  
  include Blacklight::Marc::Catalog

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 10,
      :"hl.fl" => 'mods_titleInfo_usage_primary_title_ms' 

    }
 

    config.index.thumbnail_field = :mods_location_url_access_preview_ms    

    # solr path which will be added to solr base url before the other solr params.
    #config.solr_path = 'select' 
    
    # items to show per page, each number in the array represent another option to choose from.
    #config.per_page = [10,20,50,100]

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SearchHelper#solr_doc_params) or
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}' 
    #}

    # solr field configuration for search results/index views
    config.index.title_field = 'mods_titleInfo_usage_primary_title_ms'
    config.index.display_type_field = 'format'
    

    # solr field configuration for document/show views
    #config.show.title_field = 'title_display'
    #config.show.display_type_field = 'format'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    #
    # :show may be set to false if you don't want the facet to be drawn in the 
    # facet bar
    config.add_facet_field 'mods_relatedItem_type_host_collectionFacet_ms', :label => 'Collection/Series', limit: 10
#config.add_facet_field 'a_pivot_facet', pivot: ['mods_relatedItem_type_host_series_displayForm_ms', 'mods_relatedItem_type_host_series_ms']


    config.add_facet_field 'mods_format_normalized_ms', :label => 'Format', limit: 7
    config.add_facet_field 'mods_subject_ms', :label => 'Subject', limit: 7
    config.add_facet_field 'mods_places_ms', :label => 'Place', limit: 7
    config.add_facet_field 'mods_date_facet_ms', :label => 'Date', limit: 7
    config.add_facet_field 'mods_era_facet_ms', :label => 'Date Range', limit: 7

   # config.add_facet_field 'example_query_facet_field', :label => 'Publish Date', :query => {
   #    :years_5 => { :label => 'within 5 Years', :fq => "pub_date:[#{Time.now.year - 5 } TO *]" },
   #    :years_10 => { :label => 'within 10 Years', :fq => "pub_date:[#{Time.now.year - 10 } TO *]" },
   #    :years_25 => { :label => 'within 25 Years', :fq => "pub_date:[#{Time.now.year - 25 } TO *]" }
   # }


    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    
    #config.add_index_field 'title_display', :label => 'Title'
    #config.add_index_field 'title_vern_display', :label => 'Title'
    #config.add_index_field 'author_display', :label => 'Author'
    #config.add_index_field 'author_vern_display', :label => 'Author'
    #config.add_index_field 'format', :label => 'Format'
    #config.add_index_field 'language_facet', :label => 'Language'
    #config.add_index_field 'published_display', :label => 'Published'
    #config.add_index_field 'published_vern_display', :label => 'Published'
    #config.add_index_field 'lc_callnum_display', :label => 'Call number'
    config.add_index_field 'mods_titleInfo_usage_primary_title_ms', :label => 'Title'
    config.add_index_field 'mods_name_usage_primary_displayForm_aut_ms', :label => 'Author'
    config.add_index_field 'mods_name_usage_primary_displayForm_cre_ms', :label => 'Creator'
    config.add_index_field 'mods_name_usage_primary_displayForm_pht_ms', :label => 'Photographer'
    config.add_index_field 'mods_name_displayForm_ctb_ms', :label => 'Contributor'
    config.add_index_field 'mods_date_display_ms', :label => 'Date'
    config.add_index_field 'mods_physicalDescription_extent_ms', :label => 'Physical Description'
    config.add_index_field 'mods_relatedItem_type_host_collection_ms', :label => 'Collection'
    config.add_index_field 'mods_relatedItem_type_host_series_ms', :label => 'Series'


    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    #config.add_show_field 'title_display', :label => 'Title'
    #config.add_show_field 'title_vern_display', :label => 'Title'
    #config.add_show_field 'subtitle_display', :label => 'Subtitle'
    #config.add_show_field 'subtitle_vern_display', :label => 'Subtitle'
    #config.add_show_field 'author_display', :label => 'Author'
    #config.add_show_field 'author_vern_display', :label => 'Author'
    #config.add_show_field 'format', :label => 'Format'
    #config.add_show_field 'url_fulltext_display', :label => 'URL'
    #config.add_show_field 'url_suppl_display', :label => 'More Information'
    #config.add_show_field 'language_facet', :label => 'Language'
    #config.add_show_field 'published_display', :label => 'Published'
    #config.add_show_field 'published_vern_display', :label => 'Published'
    #config.add_show_field 'lc_callnum_display', :label => 'Call number'
    #config.add_show_field 'isbn_t', :label => 'ISBN'

    # MODS This is the Full Record Display
    config.add_show_field 'mods_titleInfo_usage_primary_title_ms', :label => 'Title'
    config.add_show_field 'mods_abstract_ms', :label => 'Abstract'
    config.add_show_field 'mods_identifier_type_uri_ms', :label => 'Link to Item'
    config.add_show_field 'mods_name_usage_primary_displayForm_aut_ms', :label => 'Author', :link_to_search => 'mods_name_usage_primary_displayForm_aut_ms'
    config.add_show_field 'mods_name_usage_primary_displayForm_cre_ms', :label => 'Creator', :link_to_search => 'mods_name_usage_primary_displayForm_cre_ms'
    config.add_show_field 'mods_name_usage_primary_displayForm_pht_ms', :label => 'Photographer', :link_to_search => 'mods_name_usage_primary_displayForm_pht_ms'
    config.add_show_field 'mods_name_displayForm_crp_ms', :label => 'Correspondent'
    config.add_show_field 'mods_name_displayForm_csl_ms', :label => 'Consultant'
    config.add_show_field 'mods_name_displayForm_ctb_ms', :label => 'Contributor'
    config.add_show_field 'mods_name_displayForm_dnr_ms', :label => 'Donor'
    config.add_show_field 'mods_name_displayForm_dpt_ms', :label => 'Depositor'
    config.add_show_field 'mods_name_displayForm_dte_ms', :label => 'Dedicatee'
    config.add_show_field 'mods_name_displayForm_fmo_ms', :label => 'Former owner'
    config.add_show_field 'mods_name_displayForm_own_ms', :label => 'Owner'
    config.add_show_field 'mods_name_displayForm_prf_ms', :label => 'Performer'
    config.add_show_field 'mods_name_displayForm_rps_ms', :label => 'Repository'
    config.add_show_field 'mods_name_displayForm_trc_ms', :label => 'Transcriber'  
    config.add_show_field 'mods_date_display_ms', :label => 'Date'
    config.add_show_field 'mods_format_normalized_ms', :label => 'Format'
    config.add_show_field 'mods_genre_normalized_ms', :label => 'Genre'
    config.add_show_field 'mods_relatedItem_type_host_collection_ms', :label => 'Collection', :link_to_search => 'mods_relatedItem_type_host_collection_ms'
    config.add_show_field 'mods_relatedItem_type_host_series_ms', :label => 'Series', :link_to_search => 'mods_relatedItem_type_host_series_ms'
    config.add_show_field 'mods_relatedItem_type_host_partOf_ms', :label => 'Subseries'    
    config.add_show_field 'mods_subject_ms', :label => 'Subject', :link_to_search => 'mods_subject_ms'
    config.add_show_field 'mods_places_ms', :label => 'Place', :link_to_search => 'mods_places_ms'    
    config.add_show_field 'mods_note_ms', :label => 'Note'
    config.add_show_field 'mods_note_type_acquisition_ms', :label => 'Acquisition note'
    config.add_show_field 'mods_note_type_biographical_historical_ms', :label => 'Biographical/Historical note'
    config.add_show_field 'mods_note_type_original_location_ms', :label => 'Original location'
    config.add_show_field 'mods_note_type_reproduction_ms', :label => 'Reproduction note'    
    config.add_show_field 'mods_physicalDescription_extent_ms', :label => 'Physical Description'
    config.add_show_field 'mods_holdingSimple_copyInformation_itemIdentifier_type_local_ms', :label => 'Item Identifiers'
    config.add_show_field 'mods_language_languageTerm_type_text_authority_iso639-2b_ms', :label => 'Language'
    config.add_show_field 'mods_identifier_ms', :label => 'Identifier'
    config.add_show_field 'mods_relatedItem_type_host_findingAid_ms', :label => 'Finding Aid'
    config.add_show_field 'mods_accessCondition_type_use_and_reproduction_ms', :label => 'Use Restrictions'
    config.add_show_field 'mods_accessCondition_type_use_and_reproduction_displayLabel_Conditions_Governing_Use_note_ms', :label => 'Use Restrictions'


    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different. 

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise. 
    
    config.add_search_field 'all_fields', :label => 'All Fields'
    

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields. 
    
    config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params. 
      field.solr_parameters = { :'spellcheck.dictionary' => 'title' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = { 
        :qf => '$title_qf',
        :pf => '$title_pf'
      }
    end
    
    config.add_search_field('author') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'author' }
      field.solr_local_parameters = { 
        :qf => '$author_qf',
        :pf => '$author_pf'
      }
    end
    
    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as 
    # config[:default_solr_parameters][:qt], so isn't actually neccesary. 
    config.add_search_field('subject') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'subject' }
      field.qt = 'search'
      field.solr_local_parameters = { 
        :qf => '$subject_qf',
        :pf => '$subject_pf'
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    #config.add_sort_field 'score desc, pub_date_sort desc, title_sort asc', :label => 'relevance'
    #config.add_sort_field 'pub_date_sort desc, title_sort asc', :label => 'year'
    #config.add_sort_field 'author_sort asc, title_sort asc', :label => 'author'
    #config.add_sort_field 'title_sort asc, pub_date_sort desc', :label => 'title'
    config.add_sort_field 'score desc, mods_keydate_sort desc,mods_titleInfo_usage_primary_title_sort asc', :label => 'relevance'
    config.add_sort_field 'mods_keydate_sort desc, mods_titleInfo_usage_primary_title_sort asc', :label => 'year'
    config.add_sort_field 'mods_name_usage_primary_sort asc, mods_titleInfo_usage_primary_title_sort asc', :label => 'creator'
    config.add_sort_field 'mods_titleInfo_usage_primary_title_sort asc, mods_keydate_sort desc', :label => 'title'
    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
  end
CatalogController.blacklight_config.show.document_actions.delete(:sms)

  # Disable user authentication
  def has_user_authentication_provider?
    false
  end

end 
