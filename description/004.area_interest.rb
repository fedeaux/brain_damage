@name = 'AreaInterest'

@fields = {
  area: :belongs_to,
  owner: :'references{polymorphic}'
}

set_view_schema :single_page_manager

describe_belongs_to_field :area, :Area, :area, :name, :link_to
describe_owner_field
