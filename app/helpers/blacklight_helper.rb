module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  def presenter_class
    MyLocalPresenterClass
  end

  class MyLocalPresenterClass < Blacklight::DocumentPresenter
    def field_value_separator
      "<br />".html_safe
    end
  end

end

