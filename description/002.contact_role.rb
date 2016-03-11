@name = 'ContactRole'

@fields = {
  name: :string,
}

set_view_schema({
  type: :single_page_manager
})

describe_field :contacts, {
  relation: {
    type: :has_many
  }
}
