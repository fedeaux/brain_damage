@name = 'Area'

@fields = {
  name: :string,
  description: :text
}

set_view_schema(:type => :single_page_manager, :special_views => ['show.inline'])

describe_field :area_interests_ids, {
  relation: {
    type: :has_many,
  }
}
