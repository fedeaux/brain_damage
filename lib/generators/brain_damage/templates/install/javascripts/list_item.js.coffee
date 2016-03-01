@BrainDamage ?= {}

class @BrainDamage.ListItem
  constructor: (item_wrapper_selector) ->
    @wrapper = $ item_wrapper_selector
    @install()

  install: =>
    @item = $ '.brain-damage-list-item', @wrapper
    @form = $ '.brain-damage-edit-list-item', @wrapper

    $('.brain-damage-edit', @wrapper).click @showForm
    $('.brain-damage-cancel', @wrapper).click @hideForm

    new BrainDamage.AjaxDelete @wrapper
    new BrainDamage.AjaxForm @form, @wrapper, 'after', complete: @editComplete

  showForm: =>
    @item.hide()
    @form.fadeIn()

  hideForm: =>
    @form.hide()
    @item.fadeIn()

  editComplete: (item) =>
    @wrapper.remove()
    @wrapper = item
    @install()
