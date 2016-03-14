@BrainDamage ?= {}

class @BrainDamage.AjaxForm
  constructor: (wrapper_selector, @args = {}) ->
    @wrapper = $ wrapper_selector

    @form = $ 'form', @wrapper

    @strategy = @args.strategy or 'prepend'
    @callbacks = @args.callbacks or {}

    if @args.target
      @target = @args.target

    else if @args.target_selector
      @target = $ @args.target_selector

    else
      @target = @wrapper

    @wrapper.on 'ajax:before', @block_wrapper
    @wrapper.on 'ajax:complete', @unblock_wrapper
    @wrapper.on 'ajax:complete', @add_to_target
    @wrapper.on 'ajax:complete', @clear_form

    @wrapper.addClass 'dimmable'
    @dimmer = $ '<div class="ui dimmer">
                   <div class="ui text loader"> Wait </div>
                 </div>'

    @form.append @dimmer

  clear_form: =>
    @form[0].reset()

  block_wrapper: =>
    @dimmer.dimmer 'show'

  unblock_wrapper: =>
    @dimmer.dimmer 'hide'

  add_to_target: (event, data) =>
    try
      item = $ data.responseJSON.html

    catch
      window.location.reload()

    item.hide()

    if @strategy == 'prepend'
      @target.prepend item

    else if @strategy == 'before similar'
      $(".#{item.attr('class')}").first().before item

    else if @strategy == 'append'
      @target.append item

    else if @strategy == 'before wrapper'
      @wrapper.before item

    else if @strategy == 'after'
      @target.after item

    else if @strategy == 'replace'
      @target.html item.html()

    item.fadeIn()
    @callbacks.complete(item) if @callbacks.complete

  prepend_to_list: (item) ->
    # target is interpreted as a list
