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

set_view_schema(:type => :single_page_manager, :special_views => ['_nested.fields'])

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
