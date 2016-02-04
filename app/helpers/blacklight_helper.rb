module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  # Are there more images than just the thumbnail?
  def more_images?(item_id_array, physical_description)

    return_val = false

    # If there are item identifiers, check for a range
    if item_id_array.length > 0
      item_id_strings = item_id_array[0].split('-')

      if item_id_strings.length == 2
        return_val = true
      end

      if item_id_strings[1] and item_id_strings[0]
        return_val = item_id_strings[1] != item_id_strings[0]
      end
    else
      if physical_description.length > 0
        return_val = physical_description[0].include?('surrogates') or physical_description[0].include?('images')
      end
    end

    return_val
  end

  def presenter_class
    MyLocalPresenterClass
  end

  class MyLocalPresenterClass < Blacklight::DocumentPresenter
    def field_value_separator
      "<br />".html_safe
    end
  end


end

