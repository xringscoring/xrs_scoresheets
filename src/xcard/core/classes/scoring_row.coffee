#
# Represents a full scoring row (comprising 1/2 scoringEnd groups)
#
# endScoresData should be array of literal objects containing 'shots' array
#

class XCard.ScoringRow

  constructor: (options = {}, @endScoresData = []) ->
    @options = Object.assign({
      cellCount: 3,
      element: 'tr',
      endCount: 1,
      config: null
    }, options)

    unless @options.config?
      throw "ScoringRow requires DistanceConfig"

    @buildScoringEnds()
    @buildTotalsBlock()

  buildScoringEnds: () ->
    @scoringEnds = []
    for i in [1..@options.endCount]
      scoreData = @endScoresData[i - 1] ? {}
      scoringEnd = new XCard.ScoringEnd({
        config: @options.config,
        cellCount: @options.cellCount,
        scores: scoreData['shots'] ? []
      })
      @scoringEnds.push scoringEnd

  buildTotalsBlock: () ->
    @totalsBlock = new XCard.ScoringRowTotals({
      config: @options.config
      scoringEnds: @scoringEnds
    })

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
