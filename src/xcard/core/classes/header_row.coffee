class XCard.HeaderRow

  constructor: (options = {})->
    @options = Object.assign({
      withGolds: true,
      withHits: true,
      withPoints: false,
      withX: false,
      title: '1',
      titleCellSpan: 1
    }, options)

    @cells = [
      @getTitleCell(),
      @getRowTotalCell()
    ]

    @cells.push @getRowPointsCell() if @options.withPoints
    @cells.push @getRowHitsCell() if @options.withHits
    @cells.push @getRowGoldsCell() if @options.withGolds
    @cells.push @getRowXCell() if @options.withX
    @cells.push @getRunningTotalCell()

  getTitleCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      colSpan: @options.titleCellSpan,
      textContent: @options.title,
      className: "title-cell"
    })
    cell

  getEndTotalCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      # textContent: "et",
      className: "end-total-cell"
    })
    cell

  getRowGoldsCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: "g",
      className: "row-golds-cell"
    })
    cell

  getRowTotalCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: "rt",
      className: "row-total-cell"
    })
    cell

  getRowHitsCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: 'h',
      className: "row-hits-cell"
    })
    cell

  getRowPointsCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: 'pt',
      className: "row-points-cell"
    })
    cell

  getRowXCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: 'x',
      className: "row-x-cell"
    })
    cell

  getRunningTotalCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: 'tot',
      className: "running-total-cell"
    })
    cell

  # Refactor: already in BasicElement
  toHtmlString: ()->
    @toHtml().outerHTML

  toHtml: ()->
    element = new XCard.BasicElement({ className: 'header-row' }, 'tr').toHtml()

    # Then total cells
    for c in @cells.slice(0)
      element.appendChild(c.toHtml())
      
    element
