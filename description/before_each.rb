def describe_belongs_to_field(name, model, object_method, display_method, display_type = :text)
  describe_field name, {
    type: :belongs_to,

    input: {
      type: :simple_select,
      options: {
        model: model,
        display: display_method,
        value: :id
      },
    },

    display: {
      type: display_type,
      options: {
        method: object_method,
        display: display_method,
        null: :ignore
      }
    }
  }
end

def describe_owner_field
  describe_field :owner, {
    relation: {
      type: :belongs_to,
    },

    input: {
      type: :polymorphic_select,
      options: {
        options: [
          { model: :Contact, display: :name, value: :id },
          # { model: :Local, display: :name, value: :id },
          # { model: :User, display: :name, value: :id },
        ]
      }
    },

    display: {
      type: :link_to,
      options: {
        method: :owner,
        display: :name,
        null: :ignore
      }
    }
  }
end

def describe_join_table_field(name, options = {})
  describe_field name, {
    relation: {
      type: :has_many,
      options: options
    }
  }
end

def describe_nested_dependent_entity(name, relation_options = {}, white_list = [])
  describe_field name, {
    relation: {
      type: :has_many,
      options: relation_options
    },

    input: {
      type: :nested_form,
      white_list: white_list
    },

    display: {
      type: :inline_single_table_manager,
      options: {
        deletable: true,
        editable: true
      }
    }
  }
end

def describe_internal_fields(*fields)
  fields.each do |field|
    describe_field field, {
      type: :internal
    }
  end
end

def add_predefined_entities_descriptions(*entities)
  if entities.include? :link_to_name
    describe_field :name, {
      display: {
        type: :link_to
      }
    }
  end

  if entities.include? :links
    describe_nested_dependent_entity :links, { as: :owner }, [:url, :name]
  end

  if entities.include? :links
    describe_nested_dependent_entity :phones, { as: :owner }, [:ddi, :ddd, :prefix, :suffix, :ramal, :name]
  end

  if entities.include? :emails
    describe_nested_dependent_entity :emails, { as: :owner }, [ :name, :email ]
  end

  if entities.include? :custom_fields
    describe_nested_dependent_entity :custom_fields, { as: :owner }, [ :name, :value ]
  end

  if entities.include? :areas
    describe_listable_has_many_through(:areas, :area_interests)
    describe_join_table_field(:area_interests, as: :owner)
  end

  if entities.include? :products
    describe_listable_has_many_through(:products, :product_interests)
    describe_join_table_field(:product_interests, as: :owner) if entities.include? :product_interests
  end
end

def describe_listable_has_many_through(name, through, input_name = nil, display_method = :name)
  input_name ||= "#{name.to_s.singularize}_ids".to_sym

  describe_field name, {
    relation: {
      type: :has_many,
      options: {
        through: through,
      },
    },

    input: {
      type: :collection_check_boxes,
      unnested_white_list: { input_name => [] },
      options: {
        name: input_name,
        model: name.to_s.singularize.camelize,
        display: display_method,
        value: :id
      },
    },

    display: {
      type: :inline_edit,
      options: {
        display: {
          type: :association_list,
          options: {
            method: display_method
          }
        },
      }
    }
  }
end
