@BrainDamage ?= {}

class @BrainDamage.AjaxDelete
  constructor: (wrapper_selector, delete_button_selector = '.brain-damage-delete') ->
    @wrapper = $ wrapper_selector
    @button = $ delete_button_selector, @wrapper
    @button.click @delete

  delete: =>
    @wrapper.fadeOut
      complete: => @wrapper.remove()
