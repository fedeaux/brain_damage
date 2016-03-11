@name = 'Contact'

@fields = {
  name: :string,
  title: :string,
  contact_role: :belongs_to,
  ac_info: :string
}

set_validations({
  validations: {
    name: { presence: true }
  }
})

set_view_schema(
  type: :full_entity
)

describe_field :name, {
  display: {
    type: :link_to
  }
}

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

describe_field :area_interests, {
  relation: {
    type: :has_many,
    options: {
      as: :owner
    },
  }
}

describe_field :links, {
  relation: {
    type: :has_many,
    options: {
      as: :owner
    },
  },

  input: {
    type: :nested_form,
    white_list: [ :url, :name ]
  }
}

describe_field :areas, {
  relation: {
    type: :has_many,
    options: {
      through: :area_interests,
    },
  },

  input: {
    type: :collection_check_boxes,
    options: {
      name: :area_ids,
      model: :Area,
      display: :name,
      value: :id
    },
  },
}
