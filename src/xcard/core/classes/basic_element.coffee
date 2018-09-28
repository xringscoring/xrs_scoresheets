class XCard.BasicElement

  constructor: (options = {}, @element = 'td')->
    @attributes = {}
    @setAttributes(options)

  className: (override)->
    klass = override ? @.constructor.name.toLowerCase()
    "#{XCard.config.classPrefix}-#{klass}"

  setAttributes: (attrs = {}) ->
    @attributes = Object.assign(@attributes, attrs)

  toHtmlString: ()->
    XCard.elementToString(@element, @ensureClassnames(@attributes))

  toHtml: () ->
    XCard.makeElement(@element, @ensureClassnames(@attributes))

  # Ensure we persist the element className if new className(s) are provided
  ensureClassnames: (attrs = {})->
    classes = if attrs.className? then attrs.className.split(" ") else []
    # classes.push(@className())
    uniques = XCard.uniqueArray(classes).sort()
    attrs['className'] = uniques.join(' ')
    attrs
