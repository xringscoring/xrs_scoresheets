XCard.displayCell =(textContent, classNames, attrs = {})->
  attributes = Object.assign(attrs, {
    textContent: textContent,
    className: classNames
  })

  new XCard.BasicCell(attributes)
