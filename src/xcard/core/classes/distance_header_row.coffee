class XCard.DistanceHeaderRow

  constructor: (options = {})->
    @options = Object.assign({
      config: null
      # title: '1',
      # titleCellSpan: 1
    }, options)

    unless @options.config?
      throw "DistanceHeaderRow requires DistanceConfig"

    @config = @options.config

    @cells = [
      @getTitleCell()
    ]

    if @config.endsPerRow > 1
      @cells.push @getRowTotalCell()

    @cells.push @getRowHitsCell() if @config.withHits
    @cells.push @getRowGoldsCell() if @config.withGolds
    @cells.push @getRowXCell() if @config.withX
    @cells.push @getRowPointsCell() if @config.withPoints
    @cells.push @getRunningTotalCell()
    @cells.push @getRunningTotalPointsCell() if @config.withPoints

  getTitleCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      colSpan: @config.titleCellSpan,
      textContent: @config.title,
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
      textContent: @forDisplay("g"),
      className: "row-golds-cell"
    })
    cell

  getRowTotalCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay("rt"),
      className: "row-total-cell"
    })
    cell

  getRowHitsCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay('h'),
      className: "row-hits-cell"
    })
    cell

  getRowPointsCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay('pt'),
      className: "row-points-cell"
    })
    cell

  getRowXCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay('x'),
      className: "row-x-cell"
    })
    cell

  getRunningTotalCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay('tot'),
      className: "running-total-cell"
    })
    cell

  getRunningTotalPointsCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay('tot pt'),
      className: "running-total-points-cell"
    })
    cell

  forDisplay: (v)->
    if @options.config.withTotalHeaders then v else ''

  # Refactor: already in BasicElement
  toHtmlString: ()->
    @toHtml().outerHTML

  toHtml: ()->
    element = new XCard.BasicElement({ className: 'header-row' }, 'tr').toHtml()

    # Then total cells
    for c in @cells.slice(0)
      element.appendChild(c.toHtml())

    element
