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

    if @options.withPoints
      rowTotalPoints = @getRowTotalPoints()
      @options.totals.totalPoints += rowTotalPoints

    # TODO: wrap these in a single method
    @cells = []

    if @scoringEnds.length > 1
      @cells.push(new XCard.BasicCell({
        className: 'row-total-score row-totals',
        textContent: @forDisplay(rowTotalScore)
      }))

    if @options.config.withHits
      @cells.push(new XCard.BasicCell({
        className: 'row-hits-total row-totals',
        textContent: @forDisplay(rowTotalHits)
      }))

    if @options.config.withGolds
      @cells.push(new XCard.BasicCell({
        className: 'row-golds-total row-totals',
        textContent: @forDisplay(rowTotalGolds)
      }))

    if @options.config.withX
      @cells.push(new XCard.BasicCell({
        className: 'row-x-total row-totals',
        textContent: @forDisplay(rowTotalX)
      }))

    if @options.config.withPoints
      @cells.push(new XCard.BasicCell({
        className: 'row-points-total row-totals',
        textContent: @forDisplay(rowTotalPoints)
      }))

    @cells.push(new XCard.BasicCell({
      className: 'row-running-total row-totals'
      textContent: @forDisplay(@options.totals.totalScore)
      }))

    if @options.config.withPoints
      @cells.push(new XCard.BasicCell({
        className: 'row-running-total-points row-totals',
        textContent: @forDisplay(@options.totals.totalPoints)
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
      accum + se.totalGolds()
    , 0)

  getRowTotalX: ()->
    0

  getRowTotalHits: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalHits()
    , 0)

  getRowTotalPoints: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalPoints()
    , 0)

  getRowTotalScore: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalScore()
    , 0)
