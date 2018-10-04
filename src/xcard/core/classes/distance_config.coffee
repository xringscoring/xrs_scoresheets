class XCard.DistanceConfig

  constructor: (options = {}) ->
    @options = Object.assign({
      distanceIndex: 0,
      shotsPerEnd: 6,
      title: 'Distance',
      totalShots: 36,
      withHits: true,
      withGolds: true,
      goldScore: 10,
      withX: true,
      recurveMatch: false,
      compoundMatch: false,
      withTotalHeaders: true
      titleCellSpan: null
    }, options)

    @goldScore = @options.goldScore
    @shotsPerEnd = @options.shotsPerEnd
    @totalShots = @options.totalShots
    @title = @options.title

    @withX = @options.withX
    @withGolds = @options.withGolds
    @goldScore = @options.goldScore
    @withPoints = @showPoints()
    @withHits = @showHits()
    @withTotalHeaders = @options.withTotalHeaders

    @numberOfEnds = @totalShots / @shotsPerEnd
    @endsPerRow = @getEndsPerRow()

    @rowCount = @getRowCount()

    @cellsPerEnd = @getCellsPerEnd()
    @endTotalCells = if @endsPerRow is 1 then 0 else @endsPerRow


    @titleCellSpan = @options.titleCellSpan ? @getTitleCellSpan()

  getCellsPerEnd: ()->
    return 3 if @isMatch()

    if @shotsPerEnd <= 3
      return 3

    if @shotsPerEnd <= 6
      return 6

    12

  getEndsPerRow: ()->
    return 1 if @isMatch()
    return if @shotsPerEnd <= 6 then 2 else 1

  getRowCount: ()->
    if @isMatch() and (@options.distanceIndex > 0)
      return 3

    @numberOfEnds / @endsPerRow

  getTitleCellSpan: ()->
    (@endsPerRow * @cellsPerEnd) + @endTotalCells

  isMatch: () ->
    @options.recurveMatch or @options.compoundMatch

  showHits: () ->
    !(@options.recurveMatch or @options.compoundMatch)

  showPoints: ()->
    @options.recurveMatch
