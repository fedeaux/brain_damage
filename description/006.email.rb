set_name 'Email'

set_fields(
  email: :string,
  name: :string,
  owner: :'references{polymorphic}'
)

set_view_schema(:type => :single_page_manager, :special_views => ['_nested.fields'])
describe_owner_field
