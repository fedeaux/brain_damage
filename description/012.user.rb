set_name 'User'

set_fields(
  initials: :string,
  name: :string,
  role: :string,
)

set_validations({
  validations: {
    name: { presence: true }
  }
})

describe_internal_fields :ac_info, :ancestry

set_view_schema type: :full_entity

add_predefined_entities_descriptions(
  :link_to_name,
  :links, :phones, :custom_fields,
  :areas, :products
)
