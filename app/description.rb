BrainDamage::Application.describe do |description|
  description.scaffolds['Lead'] = {
    :fields => {
      :title => :string,
      :contents => :text
    },

    :relationships => {
      :has_many => :entries
    },

    :views => {
      :index => :single_page_manager
      #   by default a create form will include forms to add children,
      # an edit form will include forms to add or delete children
    }
  }

  description.scaffolds['Entry'] = {
    :fields => {
      :story_id => :integer,
      :contents => :text,
      :event_date => :datetime
    },

    :relationships => {
      :belongs_to => :lead
    },

    # :views can be omitted for default views
  }

  description
end
