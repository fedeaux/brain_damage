set_name 'Local'

set_fields(
  ac_info: :string,
  address: :string,
  ancestry: :string,
  category: :string,
  cep: :string,
  city: :string,
  cnpj: :string,
  corporate_name: :string,
  name: :string,
  observations: :string,
  state: :string,
  state_registration: :string,
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
  :links, :phones, :custom_fields
)
