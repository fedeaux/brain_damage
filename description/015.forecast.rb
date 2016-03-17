set_name 'Forecast'

set_fields(
  competition: :string,
  competition_level: :string,
  competitor_name: :string,
  currency: :string,
  expected_date: :date,
  funding_level: :string,
  lead_status: :string,
  observations: :text,
  price: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  purchase_probability: :string,
  reason_specified: :string,
  lead: :belongs_to,

  include_on_reports: { :type => :boolean, default: true }
)

set_view_schema type: :full_entity

describe_field :lead, {
  relation: {
    type: :has_one,
  }
}
