set_name 'LeadType'

set_fields(
  name: :string,
)

set_view_schema({
  type: :single_page_manager
})

describe_field :leads, {
  relation: {
    type: :has_many
  }
}
