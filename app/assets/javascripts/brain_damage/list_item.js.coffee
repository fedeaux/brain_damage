@BrainDamage ?= {}

class @BrainDamage.ListItem
  constructor: (item_wrapper_selector) ->
    new BrainDamage.InlineEdit item_wrapper_selector, '.brain-damage-list-item', '.brain-damage-edit-list-item', 'table.item', @editComplete

  editComplete: (item) =>
    @wrapper.remove()
    @wrapper = item
    @install()
