class XCard.DistanceTotalsRow extends XCard.BlockElement

  {displayCell} = XCard

  constructor: (options = {})->
    super(options)

    @cells = [
      @getSpacerCell(),
    ]

    @cells.push @getRowHitsCell() if @config.withHits
    @cells.push @getRowGoldsCell() if @config.withGolds
    @cells.push @getRowXCell() if @config.withX
    @cells.push @getRunningTotalCell()
    @cells.push @getRowPointsCell() if @config.withPoints
    @cells.push @getRunningTotalPointsCell() if @config.withPoints

  getCellSpan: () ->
    if @config.endsPerRow is 1
      return @config.cellsPerEnd

    (@config.endsPerRow * @config.cellsPerEnd) + (@config.endsPerRow + 1)

  getSpacerCell: ()->
    cell = new XCard.BasicCell
    cell.setAttributes({
      colSpan: @getCellSpan(),
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

  # This should be empty, as TOT PT will show overall count
  getRowPointsCell: ()->
    displayCell(@forDisplay(''), 'total-points-cell unused')

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

    for pCell in @paddingCells
      element.appendChild(pCell.toHtml())

    # Then total cells
    for c in @cells.slice(0)
      element.appendChild(c.toHtml())

    element
