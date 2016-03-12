@BrainDamage ?= {}

class @BrainDamage.AjaxForm
  constructor: (form_selector, target_selector, @strategy = 'prepend', @callbacks = {}) ->
    @form = $ form_selector
    @target = $ target_selector
    @form.on 'ajax:before', @blockForm
    @form.on 'ajax:complete', @unblockForm
    @form.on 'ajax:complete', @addToTarget
    @form.on 'ajax:complete', @clearForm

    @form.addClass 'dimmable'
    @dimmer = $ '<div class="ui dimmer">
                   <div class="ui text loader"> Wait </div>
                 </div>'

    @form.append @dimmer

  clearForm: =>
    $('form', @form)[0].reset()

  blockForm: =>
    @dimmer.dimmer('show')

  unblockForm: =>
    @dimmer.dimmer('hide')

  addToTarget: (event, data) =>
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

    else if @strategy == 'after'
      @target.after item

    else if @strategy == 'replace'
      @target.html item

    item.fadeIn()
    @callbacks.complete(item) if @callbacks.complete

  prependToList: (item) ->
    # target is interpreted as a list

  replaceOriginal: (item) ->
    # target is interpreted as the original item
    @target.before(item)
    @target.remove()
    @form.remove()
