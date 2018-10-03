class XCard.DistanceConfig

  constructor: (options = {}) ->
    @options = Object.assign({
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

  showHits: () ->
    !(@options.recurveMatch or @options.compoundMatch)

  showPoints: ()->
    @options.recurveMatch
