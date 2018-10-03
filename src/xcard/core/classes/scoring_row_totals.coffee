class XCard.ScoringRowTotals

  constructor: (options = {})->
    @options = Object.assign({
      config: null
      scoringEnds: [],
      totals: null
    }, options)

    unless @options.config?
      throw "ScoringRow totals requires DistanceConfig"

    @scoringEnds = @options.scoringEnds
    @displayTotals = @ensureAtLeastOneScoringEnd()

    @buildTotals()

  buildTotals: ()->
    rowTotalScore = @getRowTotalScore()
    @options.totals.totalScore += rowTotalScore

    rowTotalHits = @getRowTotalHits()
    @options.totals.totalHits += rowTotalHits

    rowTotalGolds = @getRowTotalGolds()
    @options.totals.totalGolds += rowTotalGolds

    rowTotalX = @getRowTotalX()
    @options.totals.totalX += rowTotalX

    @cells = [
      new XCard.BasicCell({
        className: 'row-total-score',
        textContent: @forDisplay(rowTotalScore)
        })
    ]

    if @options.config.withHits
      @cells.push(new XCard.BasicCell({
        className: 'row-hits-total',
        textContent: @forDisplay(rowTotalHits)
      }))

    # if @options.withPoints

    if @options.config.withGolds
      @cells.push(new XCard.BasicCell({
        className: 'row-golds-total',
        textContent: @forDisplay(rowTotalGolds)
      }))

    if @options.config.withX
      @cells.push(new XCard.BasicCell({
        className: 'row-x-total',
        textContent: @forDisplay(rowTotalX)
      }))

    #
    # TODO: how to calculate running total dynamically
    #
    @cells.push(new XCard.BasicCell({
      className: 'row-running-total'
      textContent: @forDisplay(@options.totals.totalScore)
      }))

  cells: ()->
    @cells

  ensureAtLeastOneScoringEnd: ()->
    @scoringEnds.filter( (sc)->
      sc.hasAtLeastOneScore()
    ).length > 0

  # Only display totals if at least one scoring end is registered
  forDisplay: (v)->
    if @displayTotals then v.toString() else ''

  getRowTotalGolds: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.endTotalCell.totalGolds()
    , 0)

  getRowTotalX: ()->
    0

  getRowTotalHits: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalHits()
    , 0)

  getRowTotalScore: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalScore()
    , 0)
