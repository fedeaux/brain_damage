@name = 'ProductInterest'

@fields = {
  product: :belongs_to,
  owner: :'references{polymorphic}'
}

set_view_schema :single_page_manager

describe_belongs_to_field :product, :Product, :product, :name, :link_to
describe_owner_field
