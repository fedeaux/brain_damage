@BrainDamage ?= {}

class @BrainDamage.InlineEdit
  constructor: (wrapper_selector, display_selector, edit_selector, partial_to_show = null, edit_complete = null) ->
    @wrapper = $ wrapper_selector
    @display_selector = display_selector
    @edit_selector = edit_selector
    @partial_to_show = partial_to_show
    @edit_complete = edit_complete

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
    if @edit_complete
      @edit_complete item

    else
      @install()
      @hideForm()
