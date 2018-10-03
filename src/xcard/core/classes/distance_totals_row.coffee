class XCard.DistanceTotalsRow

  constructor: (options = {})->
    @options = Object.assign({
      config: null,
      title: '1',
      cellSpan: 1
      totals: null
    }, options)

    unless @options.config?
      throw "DistanceTotalsRow requires DistanceConfig"

    @cells = [
      @getSpacerCell(),
    ]

    @cells.push @getRowHitsCell() if @options.config.withHits
    @cells.push @getRowGoldsCell() if @options.config.withGolds
    @cells.push @getRowXCell() if @options.config.withX
    @cells.push @getRunningTotalCell()

  getSpacerCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      colSpan: @options.cellSpan + 1,
      textContent: '',
      className: 'totals-spacer'
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
      textContent: @options.totals.totalGolds.toString(),
      className: "total-golds-cell"
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
      textContent: @options.totals.totalHits.toString(),
      className: "total-hits-cell"
    })
    cell

  getRowPointsCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @options.totals.totalPoints.toString(),
      className: "total-points-cell"
    })
    cell

  getRowXCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @options.totals.totalX.toString(),
      className: "total-x-cell"
    })
    cell

  getRunningTotalCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @options.totals.totalScore.toString(),
      className: "total-score-cell"
    })
    cell

  # Refactor: already in BasicElement
  toHtmlString: ()->
    @toHtml().outerHTML

  toHtml: ()->
    element = new XCard.BasicElement({ className: 'totals-row' }, 'tr').toHtml()

    # Then total cells
    for c in @cells.slice(0)
      element.appendChild(c.toHtml())

    element
