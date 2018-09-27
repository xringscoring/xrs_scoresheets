class XCard.BasicElement

  constructor: (options = {})->
    @element = 'td'
    @attributes = {}
    @setAttributes(options)

  setAttributes: (attrs = {}) ->
    @attributes = Object.assign(@attributes, attrs)

  toHtml: () ->
    XCard.elementToString(@element, @ensureClassnames(@attributes))

  ensureClassnames: (attrs)->
    classes = if attrs.className? then attrs.className.split(" ") else []
    classes.push(@className())
    uniques = XCard.uniqueArray(classes).sort()
    attrs['className'] = uniques.join(' ')
    attrs
