@BrainDamage ?= {}

class @BrainDamage.HideableContent
  constructor: (wrapper_selector, @args = {}) ->
    @args = $.extend @args,
      show_selector: '.brain-damage-show',
      hideable_selector: '.brain-damage-hideable-content',
      hide_selector: '.brain-damage-cancel',

    @wrapper = $ wrapper_selector

    @hideable = $ @args.hideable_selector, @wrapper
    @show_button = $ @args.show_selector, @wrapper
    @hide_button = $ @args.hide_selector, @wrapper

    @show_button.click @show
    @hide_button.click @hide

  show: =>
    @show_button.hide()
    @hideable.fadeIn()

  hide: =>
    @hideable.hide()
    @show_button.fadeIn()
