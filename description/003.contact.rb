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

set_view_schema( type: :full_entity )

describe_belongs_to_field(:contact_role, :ContactRole, :contact_role, :name)

add_predefined_entities_descriptions(
  :link_to_name, :ac_info,
  :area_interests, :product_interests,
  :links, :emails, :phones, :custom_fields,
  :areas, :products
)
