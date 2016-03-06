@name = 'AreaInterest'

@fields = {
  area: :belongs_to,
  owner: :'references{polymorphic}'
}

set_view_schema :single_page_manager

describe_field :area, {
  type: :belongs_to,

  input: {
    type: :simple_select,
    options: { model: :Area, display: :name, value: :id }
  },

  display: {
    type: :link_to,
    options: {
      method: :area,
      display: :name,
      null: :ignore
    }
  }
}
