set_name 'Contact'

set_fields(
  name: :string,
  title: :string,
  contact_role: :belongs_to,
  ac_info: :string
)

set_validations({
  validations: {
    name: { presence: true }
  }
})

set_view_schema( type: :full_entity )

describe_belongs_to_field(:contact_role, :ContactRole, :contact_role, :name)

describe_internal_fields(:ac_info)

add_predefined_entities_descriptions(
  :link_to_name,
  :links, :emails, :phones, :custom_fields,
  :areas, :products
)
