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

describe_field :area_interests_ids, {
  type: :has_many,
  type_options: {
    as: :owner
  },
}

describe_field :areas_ids, {
  type: :has_many,
  type_options: {
    through: :area_interests,
  },

  input: {
    type: :checkbox_list,
    options: {
      model: :AreaInterest,
      display: :name,
      value: :id
    },
  },

}
