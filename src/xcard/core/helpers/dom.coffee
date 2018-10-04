#= require_self

XCard.extend

  elementToString: (tagName, options = {}) ->
    element = XCard.makeElement(tagName, options)
    element.outerHTML

  makeElement: (tagName, options = {}) ->
    element = document.createElement(tagName)

    if options.attributes
      for key, value of options.attributes
        element.setAttribute(key, value)

    if options.style
      for key, value of options.style
        element.style[key] = value

    if options.data
      for key, value of options.data
        element.dataset[key] = value

    if options.className
      for className in options.className.split(" ")
        element.classList.add(className)

    if options.textContent
      element.textContent = options.textContent

    # Table-specific
    if options.colSpan
      element.setAttribute('colspan', options.colSpan)

    element
