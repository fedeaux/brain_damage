@name = 'Contact'

@fields = {
  name: :string,
  title: :string,
  contact_role_id: :integer,
  ac_info: :string
}

@view_schema = :full_entity

specify_input :contact_role_id, {
  type: :select,
  parameters: [:name, :id]
}

# add_form_field :contact_role_id, {
#   type: :select,
#   parameters: [:name, :id]
# }
