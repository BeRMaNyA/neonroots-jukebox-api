module ApplicationHelper
  def pagination_hash(object)
    {
      :total => object.total_entries,
      :total_pages => object.total_entries/object.per_page,
      :current_page =>object.current_page
    }
  end
end
