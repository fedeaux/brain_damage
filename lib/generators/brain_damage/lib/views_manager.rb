module BrainDamage
  class ViewsManager
    def initialize(args = {})
    end

    def available_views
      %w(index show _form _fields _single_page_manager _table.item _table.header _table.form _table.item.form)
    end
  end
end
