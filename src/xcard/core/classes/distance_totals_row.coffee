class XCard.DistanceTotalsRow

  constructor: (options = {})->
    @options = Object.assign({
      config: null,
      # title: '1',
      # cellSpan: 1
      totals: null
    }, options)

    unless @options.config?
      throw "DistanceTotalsRow requires DistanceConfig"

    @config = @options.config

    @cells = [
      @getSpacerCell(),
    ]

    @cells.push @getRowHitsCell() if @options.config.withHits
    @cells.push @getRowGoldsCell() if @options.config.withGolds
    @cells.push @getRowXCell() if @options.config.withX
    @cells.push @getRowPointsCell() if @options.config.withPoints
    @cells.push @getRunningTotalCell()
    @cells.push @getRunningTotalPointsCell() if @options.config.withPoints

  getSpacerCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      colSpan: @config.titleCellSpan + (if @config.endsPerRow > 1 then 1 else 0),
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
      textContent: @forDisplay(@options.totals.totalGolds.toString()),
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
      textContent: @forDisplay(@options.totals.totalHits.toString()),
      className: "total-hits-cell"
    })
    cell

  getRowPointsCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay(@options.totals.totalPoints.toString()),
      className: "total-points-cell"
    })
    cell

  getRowXCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay(@options.totals.totalX.toString()),
      className: "total-x-cell"
    })
    cell

  getRunningTotalCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay(@options.totals.totalScore.toString()),
      className: "total-score-cell"
    })
    cell

  getRunningTotalPointsCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      textContent: @forDisplay(@options.totals.totalPoints.toString()),
      className: "total-points-cell"
    })
    cell

  forDisplay: (v)->
    return '' unless @options.totals.totalScore > 0
    v

  # Refactor: already in BasicElement
  toHtmlString: ()->
    @toHtml().outerHTML

  toHtml: ()->
    element = new XCard.BasicElement({ className: 'totals-row' }, 'tr').toHtml()

    # Then total cells
    for c in @cells.slice(0)
      element.appendChild(c.toHtml())

    element
