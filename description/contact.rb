@name = 'Contact'

@fields = {
  name: :string,
  title: :string,
  contact_role: :belongs_to,
  ac_info: :string
}

set_view_schema(
  type: :full_entity
)

describe_field :contact_role, {
  type: :belongs_to,

  input: {
    type: :simple_select,
    options: {
      model: :ContactRole,
      display: :name,
      value: :id
    },
  },

  display: {
    type: :text,
    options: {
      method: :contact_role,
      display: :name,
      null: :ignore
    }
  }
}

describe_field :ac_info, {
  type: :internal
}
