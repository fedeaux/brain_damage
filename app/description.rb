BrainDamage::Application.describe do |d|
  d.add_scaffold('Area') do |s|
    s.fields = {
      name: :string,
      description: :text,
    }

    # views(:single_page_manager)
  end

  d.add_scaffold('Contact') do |s|
    s.fields = {
      name: :string,
      title: :string,
      contact_role_id: :integer,
      ac_column: :string
    }

    # views: {
    #   schema: :full_entity,
    #   views: {
    #     forms: {
    #       fields=: {
    #         contact_role_id: {
    #           type: :select,
    #           parameters: [:name, :id]
    #         }
    #       }
    #     }
    #   }
    # }
  end

  d.add_scaffold('Commission') do |s|
    s.fields = {
      user_id: :integer,
      percentage: { type: :decimal, precision: 4, scale: 2 },
      contact_role_id: :integer,
      ac_column: :string
    }

  #   views: {
  #     schema: :full_entity,
  #     views: {
  #       forms: {
  #         fields=: {
  #           contact_role_id: {
  #             type: :select,
  #             parameters: [:name, :id]
  #           }
  #         }
  #       }
  #     }
  #   }
  # }
  end

  d.add_scaffold('Document') do |s|
    s.fields = {
      name: :string,
      archive: :string,
      description: :string,
      owner_id: :integer,
      owner_type: :integer
    }
  end

  d.add_scaffold('Lead') do |s|
    s.fields = {
      title: :string,
      contents: :text
    }

    # views: {
    #   schema: :full_entity
    # }
  end

  d.add_scaffold('Entry') do |s|
    s.fields = {
      lead_id: :integer,
      contents: :text,
      event_date: :datetime
    }

    # relationships: {
    #   belongs_to: :lead
    # },

    # views: {
    #   schema: :dependent_only,
    #   relationships: {
    #     lead: {
    #       type: :none
    #     }
    #   }
    # }
  end

  d.add_scaffold('User') do |s|
    s.fields = {
      lead_id: :integer,
      contents: :text,
      event_date: :datetime
    }

    # relationships: {
    #   belongs_to: :lead
    # },

    # views: {
    #   type: :dependent_only,
    #   relationships: {
    #     lead: {
    #       type: :none
    #     }
    #   }
      #   by default a create form will include forms to add children,
      # an edit form will include forms to add or delete children
  end
end
