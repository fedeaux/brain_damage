@name = 'ProductInterest'

@fields = {
  product: :belongs_to,
  owner: :'references{polymorphic}'
}

set_view_schema :single_page_manager

describe_field :product, {
  relation: {
    type: :belongs_to,
  },

  input: {
    type: :simple_select,
    options: { model: :Product, display: :name, value: :id }
  },

  display: {
    type: :link_to,
    options: {
      method: :product,
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
        # { model: :Local, display: :name, value: :id },
        # { model: :User, display: :name, value: :id },
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
