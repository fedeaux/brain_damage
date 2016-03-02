@name = 'Area'

@fields = {
  name: :string,
  description: :text
}

set_view_schema :single_page_manager

add_plugin :list_select, display: :name # value: :id by default
