@name = 'Link'

@fields = {
  url: :string,
  name: :string,
  owner: :'references{polymorphic}'
}

set_view_schema(:type => :single_page_manager, :special_views => ['nested.fields', 'show.inline'])
describe_owner_field
