module Admin::BaseHelper
  def filter_type_checked?(type, form = :match_search)
    params&.[](form)&.[](:type) == type
  end
end
