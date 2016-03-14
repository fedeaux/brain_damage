@BrainDamage ?= {}

class @BrainDamage.TrailingForm
  constructor: (wrapper_selector, partial_to_show, hideable_args = {}) ->
    hideable_args.wrapper_selector = wrapper_selector unless hideable_args.wrapper_selector?

    $(wrapper_selector).on 'ajax:complete', @hide_form

    @hideable_content = new BrainDamage.HideableContent hideable_args.wrapper_selector, hideable_args

    if partial_to_show
      @ajax_form.form.append "<input type='hidden' name='partial_to_show' value='#{partial_to_show}' />"

  hide_form: =>
    @hideable_content.hide()
