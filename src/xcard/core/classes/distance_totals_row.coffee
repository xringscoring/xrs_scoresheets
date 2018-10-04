class XCard.DistanceTotalsRow

  {displayCell} = XCard

  constructor: (options = {})->
    @options = Object.assign({
      config: null,
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

  getRowGoldsCell: ()->
    displayCell(@forDisplay(@options.totals.totalGolds.toString()), 'total-golds-cell')

  getRowTotalCell: ()->
    displayCell('rt', 'row-total-cell')

  getRowHitsCell: ()->
    displayCell(@forDisplay(@options.totals.totalHits.toString()), 'total-hits-cell')

  getRowPointsCell: ()->
    displayCell(@forDisplay(@options.totals.totalPoints.toString()), 'total-points-cell')

  getRowXCell: ()->
    displayCell(@forDisplay(@options.totals.totalX.toString()), 'total-x-cell')

  getRunningTotalCell: ()->
    displayCell(@forDisplay(@options.totals.totalScore.toString()), 'total-score-cell')

  getRunningTotalPointsCell: ()->
    displayCell(@forDisplay(@options.totals.totalPoints.toString()), 'total-points-cell')

  forDisplay: (v)->
    return '' unless @options.totals.totalScore > 0
    v

  toHtml: ()->
    element = new XCard.BasicElement({ className: 'totals-row' }, 'tr').toHtml()

    # Then total cells
    for c in @cells.slice(0)
      element.appendChild(c.toHtml())

    element
