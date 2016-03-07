@name = 'AreaInterest'

@fields = {
  area: :belongs_to,
  owner: :'references{polymorphic}'
}

set_view_schema :single_page_manager

describe_field :area, {
  relation: {
    type: :belongs_to,
  },

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

describe_field :owner, {
  relation: {
    type: :belongs_to,
  },

  input: {
    type: :polymorphic_select,
    options: {
      options: [
        { model: :Contact, display: :name, value: :id },
        { model: :Local, display: :name, value: :id },
        { model: :User, display: :name, value: :id },
      ]
    }
  },

  display: {
    type: :link_to,
    options: {
      method: :owner,
      display: :name,
      null: :ignore
    }
  }
}
