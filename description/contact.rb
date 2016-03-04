@name = 'Contact'

@fields = {
  name: :string,
  title: :string,
  contact_role_id: :integer,
  ac_info: :string
}

set_view_schema(
  type: :full_entity
)

# specify_input :contact_role_id, {
#   type: :simple_select,
#   parameters: { display: :name, value: :id}
# }

specify_input :ac_info, {
  type: :hidden
}
