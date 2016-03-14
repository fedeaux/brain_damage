@BrainDamage ?= {}

class @BrainDamage.NestedFormControls
  @globalConfiguration = {}

  constructor: (wrapperSelector, @name, @context = 'new', @prototypeSelector = '.brain-damage-nested-form-prototype', addButtonSelector = '.brain-damage-nested-form-add-button', removeButtonSelector = '.brain-damage-nested-form-remove-button') ->

    @wrapper = $ wrapperSelector
    @submit = $ ':submit', @wrapper

    @prototype = $ @prototypeSelector, @wrapper
    @addButton = $ addButtonSelector, @wrapper
    @container = @prototype.parent()

    @init()

    @checkSubmitVisibility()

    @addButton.on 'click', @addLine
    @container.on 'click', removeButtonSelector, @removeThisLine

  checkSubmitVisibility: =>
    if @numberOfLines() > 0
      @submit.parent().append(@submit)
      @submit.fadeIn()
    else
      @submit.hide()

  numberOfLines: ->
    $(@prototypeSelector, @wrapper).length

  preparePrototypeHtml: ->
    replacements = []

    $('[name]', @prototype).each (i, _input) =>
      input = $ _input
      name = input.attr('name')
      input.attr 'name', name.replace('[0]', "[#{@placeholder}]")

    @prototypeHtml = @prototype.get(0).outerHTML

    @prototype.remove()

    @addLine() if @context == 'new'

  addLine: =>
    return if @numberOfLines() > 0 and @context == 'add'

    @i = (new Date).getTime()

    line = $ @prototypeHtml.replace(@placeholderRegexp, @i)
    line.hide()
    @container.append line
    line.fadeIn()

    @checkSubmitVisibility()

    if NestedFormControls.globalConfiguration.afterAddLine?
      NestedFormControls.globalConfiguration.afterAddLine line

  removeThisLine: (e) =>
    line = $(e.target).parents @prototypeSelector
    line.fadeOut =>
      line.remove()
      @checkSubmitVisibility()

  init: ->
    @placeholder = @name+'-index'
    @placeholderRegexp = new RegExp(@placeholder, 'g')

    @i = 0
    @preparePrototypeHtml()
