@name = 'Phone'

@fields = {
  ddi: :string,
  ddd: :string,
  prefix: :string,
  suffix: :string,
  ramal: :string,
  name: :string,
  owner: :'references{polymorphic}'
}

set_view_schema(:type => :single_page_manager, :special_views => ['nested.fields'])
describe_owner_field
