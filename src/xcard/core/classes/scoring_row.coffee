#
# Represents a full scoring row (comprising 1/2 scoringEnd groups)
#
# endScoresData should be array of literal objects containing 'shots' array
#

class XCard.ScoringRow

  constructor: (options = {}, @endScoresData = []) ->
    @options = Object.assign({
      rowIndex: 0,
      element: 'tr',
      # endCount: 1,
      config: null
      totals: null
    }, options)

    unless @options.config?
      throw "ScoringRow requires DistanceConfig"

    @config = @options.config
    @buildScoringEnds()
    @buildTotalsBlock()

  buildScoringEnds: () ->
    @scoringEnds = []
    for i in [1..@config.endsPerRow]
      scoreData = @endScoresData[i - 1] ? {}
      scoringEnd = new XCard.ScoringEnd({
        endInUse: @ensureEndInUse(i),
        config: @config,
        cellCount: @config.cellsPerEnd,
        scores: scoreData['shots'] ? [],
        points: scoreData['matchPoints'] ? 0
      })
      @scoringEnds.push scoringEnd

  buildTotalsBlock: () ->
    @totalsBlock = new XCard.ScoringRowTotals({
      config: @config,
      scoringEnds: @scoringEnds,
      totals: @options.totals
    })

  ensureEndInUse: (endNumber)->
    ((@options.rowIndex + 1) * endNumber) <= @config.numberOfEnds

  toHtml: ()->
    element = XCard.makeElement(@options.element, {
      className: 'scoring-row'
    })

    for se in @scoringEnds
      for sc in se.cells()
        element.appendChild(sc.toHtml())

    for rt in @totalsBlock.cells
      element.appendChild(rt.toHtml())

    element
