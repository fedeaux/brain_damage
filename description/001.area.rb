@name = 'Area'

@fields = {
  name: :string,
  description: :text
}

describe_field :area_interests_ids, {
  relation: {
    type: :has_many,
  }
}

set_view_schema :single_page_manager
