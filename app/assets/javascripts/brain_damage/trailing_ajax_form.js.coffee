@BrainDamage ?= {}

class @BrainDamage.TrailingAjaxForm
  constructor: (wrapper_selector) ->
    @wrapper = $ wrapper_selector
    @triggerWrapper = $ '.brain-damage-trigger', @wrapper
    @formWrapper = $ '.brain-damage-hidden-form', @wrapper

    @showButton = $ '.brain-damage-show', @wrapper
    @cancelButton = $ '.brain-damage-cancel', @formWrapper

    @showButton.click =>
      @triggerWrapper.hide()
      @formWrapper.fadeIn()

    @cancelButton.click =>
      @formWrapper.hide()
      @triggerWrapper.fadeIn()
