@BrainDamage ?= {}

class @BrainDamage.SinglePageManager
  constructor: (wrapper_selector) ->
    @wrapper = $ wrapper_selector

    if @wrapper.is '.brain-damage-list'
      @list = @wrapper
    else
      @list = $ '.brain-damage-list', @wrapper

    @forms_wrappers = $ '.brain-damage-add-form-wrapper', @wrapper

    $('.brain-damage-list-item-wrapper', @list).each @iterate_install

    @forms_wrappers.each (i, _form_wrapper) =>
      new BrainDamage.AjaxForm $(_form_wrapper),
        target: $ 'thead', @list
        strategy: 'after'
        callbacks:
          complete: @install_list_item

  iterate_install: (i, _item_wrapper) =>
    @install_list_item _item_wrapper

  install_list_item: (item_wrapper) =>
    new BrainDamage.ListItem item_wrapper
