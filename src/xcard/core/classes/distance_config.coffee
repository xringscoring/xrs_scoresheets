class XCard.DistanceConfig

  constructor: (options = {}, scoreData = {}, totalizer = null) ->
    @options = Object.assign({
      distanceIndex: 0,
      shotsPerEnd: 6,
      title: 'Distance',
      totalShots: 36,
      withHits: true,
      withGolds: true,
      goldScore: 10,
      goldsDescriptor: 'g',
      withX: true,
      recurveMatch: false,
      compoundMatch: false,
      withTotalHeaders: true
      titleCellSpan: null,
      leftPaddingCellCount: 0
    }, options)

    @scoreData = scoreData

    # Transpose various options/config items into this object
    @distanceIndex = @options.distanceIndex
    @goldScore = @options.goldScore
    @leftPaddingCellCount = @options.leftPaddingCellCount
    @shotsPerEnd = @getShotsPerEnd()
    @totalShots = @options.totalShots
    @title = @options.title

    @withX = @options.withX
    @withGolds = @options.withGolds
    @goldScore = @options.goldScore
    @goldsDescriptor = @options.goldsDescriptor
    @withPoints = @showPoints()
    @withHits = @showHits()

    @withTotalHeaders = @options.withTotalHeaders
    @totalsOrder = [ 't', 'h', 'g', 'x', 'rt', 'p', 'tp']

    @numberOfEnds = @totalShots / @shotsPerEnd
    @endsPerRow = @getEndsPerRow()
    @rowCount = @getRowCount()
    @cellsPerEnd = @getCellsPerEnd()
    @endTotalCells = if @endsPerRow is 1 then 0 else @endsPerRow

    # @titleCellSpan = @options.titleCellSpan ? @getTitleCellSpan()

  getCellsPerEnd: ()->
    return 3 if @isMatch()

    if @shotsPerEnd <= 3
      return 3

    if @shotsPerEnd is 5
      return 5

    if @shotsPerEnd <= 6
      return 6

    12

  getEndsPerRow: ()->
    return 1 if @isMatch()
    return if @shotsPerEnd <= 6 then 2 else 1

  getRowCount: ()->
    if @isMatch() and (@options.distanceIndex > 0)
      return 3

    # Some round have 1.5 dozen, for example, but we always
    # want complete rows
    Math.round(@numberOfEnds / @endsPerRow)

  # Enable override of target round definition by incoming
  # scoring data
  getShotsPerEnd: ()->
    @scoreData.shotsPerEnd or @options.shotsPerEnd

  isMatch: () ->
    @options.recurveMatch or @options.compoundMatch

  showHits: () ->
    !(@options.recurveMatch or @options.compoundMatch)

  showPoints: ()->
    @options.recurveMatch
