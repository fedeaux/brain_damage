BrainDamage::Application.describe do |d|
  d.add_scaffold('Area') do |s|
    s.fields = {
      name: :string,
      description: :text,
    }

    s.view_schema = :single_page_manager
  end

  d.add_scaffold('Contact') do |s|
    s.fields = {
      name: :string,
      title: :string,
      contact_role_id: :integer,
      ac_column: :string
    }

    s.view_schema = :full_entity

    s.form_fields = {
      contact_role_id: {
        type: :select,
        parameters: [:name, :id]
      }
    }
  end

  d.add_scaffold('Email') do |s|
    s.fields = {
      name: :string,
      description: :text,
      onwer_id: :integer,
      owner_type: :string,
      primary: :boolean
    }

    s.view_schema = :dependent_only
  end

  # d.add_scaffold('Commission') do |s|
  #   s.fields = {
  #     user_id: :integer,
  #     percentage: { type: :decimal, precision: 4, scale: 2, default: 0.0 },
  #     value: { type: :decimal, precision: 12, scale: 2, default: 0.0 },
  #     type: :string,
  #     financial_id: :integer,
  #   }

  #   view_schema = :single_page_manager
  # end

  # d.add_scaffold('Document') do |s|
  #   s.fields = {
  #     name: :string,
  #     archive: :string,
  #     description: :string,
  #     owner_id: :integer,
  #     owner_type: :integer
  #   }

  #   view_schema = :single_page_manager
  # end

  d.add_scaffold('Lead') do |s|
    s.fields = {
      title: :string,
      contents: :text
    }
  end

  d.add_scaffold('Entry') do |s|
    s.fields = {
      lead_id: :integer,
      contents: :text,
      event_date: :datetime
    }
  end

  d.add_scaffold('User') do |s|
    s.fields = {
      lead_id: :integer,
      contents: :text,
      event_date: :datetime
    }
  end
end
