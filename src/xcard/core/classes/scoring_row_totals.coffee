class XCard.ScoringRowTotals

  {displayCell} = XCard

  constructor: (options = {})->
    @options = Object.assign({
      config: null
      scoringEnds: [],
      totals: null
    }, options)

    unless @options.config?
      throw "ScoringRow totals requires DistanceConfig"

    @config = @options.config
    @scoringEnds = @options.scoringEnds
    @displayTotals = @ensureAtLeastOneScoringEnd()

    @totalsFunctionMap =
      'h': [ 'getRowHitsCell', @config.withHits ],
      'g': [ 'getRowGoldsCell', @config.withGolds ],
      'x': [ 'getRowXCell', @config.withX ],
      'p': [ 'getRowPointsCell', @config.withPoints ],
      't': [ 'getRowTotalCell', @scoringEnds.length > 1 ],
      'rt': [ 'getRunningTotalCell', true ]
      'tp': [ 'getRunningTotalPointsCell', @config.withPoints ]

    @buildTotals()

  buildTotals: ()->
    @rowTotalPoints = 0

    @rowTotalScore = @getRowTotalScore()
    @options.totals.totalScore += @rowTotalScore

    @rowTotalHits = @getRowTotalHits()
    @options.totals.totalHits += @rowTotalHits

    @rowTotalGolds = @getRowTotalGolds()
    @options.totals.totalGolds += @rowTotalGolds

    @rowTotalX = @getRowTotalX()
    @options.totals.totalX += @rowTotalX

    if @config.withPoints
      @rowTotalPoints = @getRowTotalPoints()
      @options.totals.totalPoints += @rowTotalPoints

    # TODO: wrap these in a single method
    @cells = []

    for totalsItem in @config.totalsOrder
      f = @totalsFunctionMap[totalsItem]
      if f[1]
        @cells.push @[f[0]]()

  getRowTotalCell: ()->
    displayCell(@forDisplay(@rowTotalScore), 'row-total-score row-totals')

  getRowHitsCell: ()->
    displayCell(@forDisplay(@rowTotalHits), 'row-hits-total row-totals')

  getRowGoldsCell: ()->
    displayCell(@forDisplay(@rowTotalGolds), 'row-golds-total row-totals')

  getRowXCell: ()->
    displayCell(@forDisplay(@rowTotalX), 'row-x-total row-totals')

  getRowPointsCell: ()->
    displayCell(@forDisplay(@rowTotalPoints), 'row-points-total row-totals')

  getRunningTotalCell: ()->
    displayCell(@forDisplay(@options.totals.totalScore), 'row-running-total row-totals')

  getRunningTotalPointsCell: ()->
    displayCell(@forDisplay(@options.totals.totalPoints), 'row-running-total-points row-totals')

  cells: ()->
    @cells

  ensureAtLeastOneScoringEnd: ()->
    @scoringEnds.filter( (se)->
      se.hasAtLeastOneScore()
    ).length > 0

  # Only display totals if at least one scoring end is registered
  forDisplay: (v)->
    if @displayTotals then v.toString() else ''

  getRowTotalGolds: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalGolds()
    , 0)

  getRowTotalX: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalX()
    , 0)

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
