@BrainDamage ?= {}

class @BrainDamage.TrailingAjaxForm
  constructor: (wrapper_selector, partial_to_show = nil, ajaxform_args = {}, hideable_args = {}) ->
    ajaxform_args.wrapper_selector = wrapper_selector unless ajaxform_args.wrapper_selector?
    hideable_args.wrapper_selector = wrapper_selector unless hideable_args.wrapper_selector?

    @ajax_form = new BrainDamage.AjaxForm ajaxform_args.wrapper_selector, ajaxform_args
    @hideable_content = new BrainDamage.HideableContent hideable_args.wrapper_selector, hideable_args

    if partial_to_show
      @ajax_form.form.append "<input type='hidden' name='partial_to_show' value='#{partial_to_show}' />"
