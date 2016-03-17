set_name 'Lead'

set_fields(
  awb: :string,
  client_purchase_order: :string,
  commercial_invoice: :string,
  delivered_on: :date,
  delivered_to_instrutec_on: :date,
  estimated_date: :date,

  observations: :text,
  registered_on: :date,
  requirement_placed_on: :date,
  sales_order: :string,
  shipment_observations: :text,
  shipped_at: :date,
  signature: :text,
  name: :string,
  subtype: :string,
  type: :string,

  disabled: :boolean,
  has_files_pendencies: :boolean,
  has_pendencies: :boolean,
  installation_date: :date,
  installation_date_to_be_defined: :boolean,
  installation_required: :boolean,
  installed: :boolean,

  purchase_order: :string,
  purchase_order_type: :string,
  level: :integer,

  evolved_to_1_at: :datetime,
  evolved_to_2_at: :datetime,
  evolved_to_3_at: :datetime,
  evolved_to_4_at: :datetime,
  evolved_to_5_at: :datetime,
  evolved_to_6_at: :datetime,

  evolved_to_1_by: { type: :belongs_to, class_name: 'User'},
  evolved_to_2_by: { type: :belongs_to, class_name: 'User'},
  evolved_to_3_by: { type: :belongs_to, class_name: 'User'},
  evolved_to_4_by: { type: :belongs_to, class_name: 'User'},
  evolved_to_5_by: { type: :belongs_to, class_name: 'User'},
  evolved_to_6_by: { type: :belongs_to, class_name: 'User'},
  created_by: { type: :belongs_to, class_name: 'User'},
  delivery_agent: { type: :belongs_to, class_name: 'Local'},
  exporter: { type: :belongs_to, class_name: 'Local'},

  ac_info: :text,

  bill_to: :'references{polymorphic}',

  financial: :belongs_to,
  forecast: :belongs_to,
  local: :belongs_to,
)

set_validations({
  validations: {
    name: { presence: true }
  }
})

set_view_schema( type: :full_entity )

describe_belongs_to_field(:contact_role, :ContactRole, :contact_role, :name)

add_predefined_entities_descriptions(
  :link_to_name,
  :links, :custom_fields,
  :areas, :products
)

describe_belongs_to_field(:type, :LeadType, :type, :name)
