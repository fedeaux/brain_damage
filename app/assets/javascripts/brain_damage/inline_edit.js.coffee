@BrainDamage ?= {}

class @BrainDamage.InlineEdit
  constructor: (wrapper_selector, display_selector, edit_selector, partial_to_show = null) ->
    @wrapper = $ wrapper_selector
    @display_selector = display_selector
    @edit_selector = edit_selector
    @partial_to_show = partial_to_show

    @install()

  install: =>
    @display = $ @display_selector, @wrapper
    @edit = $ @edit_selector, @wrapper
    @form = $ 'form', @edit

    $('.brain-damage-edit', @wrapper).click @showForm
    $('.brain-damage-cancel', @wrapper).click @hideForm

    new BrainDamage.AjaxDelete @wrapper
    new BrainDamage.AjaxForm @edit, @wrapper, 'replace', complete: @editComplete

    if @partial_to_show
      @form.append "<input type='hidden' name='partial_to_show' value='#{@partial_to_show}' />"

  showForm: =>
    @display.hide()
    @edit.fadeIn()

  hideForm: =>
    @edit.hide()
    @display.fadeIn()

  editComplete: (item) =>
    @install()
    @hideForm()
