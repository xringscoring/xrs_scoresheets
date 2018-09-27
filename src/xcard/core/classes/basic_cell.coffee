class XCard.BasicCell extends XCard.BasicElement

  constructor: (options = {})->
    super(options)

  className: () ->
    "#{XCard.config.classPrefix}-cell"
    
