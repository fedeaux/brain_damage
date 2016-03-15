@name = 'Contact'

@fields = {
  name: :string,
  title: :string,
  contact_role: :belongs_to,
  ac_info: :string
}

set_validations({
  validations: {
    name: { presence: true }
  }
})

set_view_schema(
  type: :full_entity
)

describe_field :name, {
  display: {
    type: :link_to
  }
}

describe_field :contact_role, {
  type: :belongs_to,

  input: {
    type: :simple_select,
    options: {
      model: :ContactRole,
      display: :name,
      value: :id
    },
  },

  display: {
    type: :text,
    options: {
      method: :contact_role,
      display: :name,
      null: :ignore
    }
  }
}

describe_field :ac_info, {
  type: :internal
}

describe_field :area_interests, {
  relation: {
    type: :has_many,
    options: {
      as: :owner
    },
  }
}

describe_field :product_interests, {
  relation: {
    type: :has_many,
    options: {
      as: :owner
    },
  }
}

describe_field :links, {
  relation: {
    type: :has_many,
    options: {
      as: :owner
    },
  },

  input: {
    type: :nested_form,
    white_list: [ :url, :name ]
  },

  display: {
    type: :inline_single_table_manager,
    options: {
      deletable: true,
      editable: true
    }
  }
}

describe_field :phones, {
  relation: {
    type: :has_many,
    options: {
      as: :owner
    },
  },

  input: {
    type: :nested_form,
    white_list: [ :ddi, :ddd, :prefix, :suffix, :ramal, :name ]
  },

  display: {
    type: :inline_single_table_manager,
    options: {
      deletable: true,
      editable: true
    }
  }
}

describe_field :emails, {
  relation: {
    type: :has_many,
    options: {
      as: :owner
    },
  },

  input: {
    type: :nested_form,
    white_list: [ :name, :email ]
  },

  display: {
    type: :inline_single_table_manager,
    options: {
      deletable: true,
      editable: true
    }
  }
}

describe_field :custom_fields, {
  relation: {
    type: :has_many,
    options: {
      as: :owner
    },
  },

  input: {
    type: :nested_form,
    white_list: [ :name, :email ]
  },

  display: {
    type: :inline_single_table_manager,
    options: {
      deletable: true,
      editable: true
    }
  }
}

describe_field :areas, {
  relation: {
    type: :has_many,
    options: {
      through: :area_interests,
    },
  },

  input: {
    type: :collection_check_boxes,
    unnested_white_list: { :area_ids => [] },
    options: {
      name: :area_ids,
      model: :Area,
      display: :name,
      value: :id
    },
  },

  display: {
    type: :inline_edit,
    options: {
      display: {
        type: :association_list,
        options: {
      # item: {
      #   type: :link_to,
      #   options: {
      #     display: :name,
      #     null: :ignore
      #   }
      # }
          method: :name
        }
      },
    }
  }
}

describe_field :products, {
  relation: {
    type: :has_many,
    options: {
      through: :product_interests,
    },
  },

  input: {
    type: :collection_check_boxes,
    unnested_white_list: { :product_ids => [] },
    options: {
      name: :product_ids,
      model: :Product,
      display: :name,
      value: :id
    },
  },

  display: {
    type: :inline_edit,
    options: {
      display: {
        type: :association_list,
        options: {
      # item: {
      #   type: :link_to,
      #   options: {
      #     display: :name,
      #     null: :ignore
      #   }
      # }
          method: :name
        }
      },
    }
  }
}
