class XCard.Scorecard

  constructor: (options = {})->
    @options = Object.assign(
      tableElement: null
      targetRoundDefinition: {}
      scoreData: {}
      bowType: 'recurve'
    , options)

    sdAdapter = new XCard.ScoreDataAdapter(@options.scoreData)
    trAdapter = new XCard.TargetDataAdapter(@options.targetRoundDefinition, @options.bowType)

    @totalizer = new XCard.Totalizer

    @distanceBlocks = []

    for tDistance, dIndex in trAdapter.distances
      sDistance = sdAdapter.distances[dIndex] ? {}
      dConfig = new XCard.DistanceConfig(tDistance, sDistance)
      dBlock = new XCard.DistanceBlock({ config: dConfig, totalizer: @totalizer }, sDistance.distanceEnds ? [])
      @distanceBlocks.push(dBlock)

  html: ()->
    html = "<thead></thead>"

    for block in @distanceBlocks
      html += block.toHtml().outerHTML

    html
