set_name 'Financial'

set_fields(
  bank_charges: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  bs_charges: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  client_order_value: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  commission_currency: { type: :string, default: "R$" },
  commission_paid_value: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  delivery_expenses: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  exchange_rate_commission_order: { type: :decimal, precision: 12, scale: 3, default: 1.0 },
  exporter_currency: { type: :string, default: "R$" },
  exporter_paid_at: :date,
  exporter_paid_value: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  exporter_po_value: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  icms_bs_aliquot: { type: :decimal, precision: 4, scale: 2, default: 0.0 },
  icms_credit: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  incoterm: :string,
  instrutec_commission_percentage: { type: :decimal, precision: 4, scale: 2, default: 20.0 },
  instrutec_paid_at: :date,
  instrutec_paid_value: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  international_expenses: { type: :decimal, recision:12,scale:2,default:0.0 },
  manual_final_net_value: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  nationalization: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  non_commissionable_values: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  operational_cost: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  order_commission: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  order_currency: { type: :string, default: "R$" },
  order_proform: :string,
  other_charges: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  other_charges_observations: :text,
  other_expenses: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  other_expenses_observations: :text,
  paid: { type: :boolean, default: false },
  parts_cost: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  parts_price: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  payment_form: { type: :string },
  reals_commission_exchange_rate: { type: :decimal, precision: 12, scale: 3, default: 1.0 },
  reals_exporter_exchange_rate: { type: :decimal, precision: 12, scale: 3, default: 1.0 },
  service_observations: :text,
  service_price: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  taxes: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  taxes_2: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
)

set_view_schema type: :full_entity

describe_field :lead, {
  relation: {
    type: :has_one,
  }
}
