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
      shotsPerEnd: 3,
      withX: false,
      withGolds: false,
      withHits: false,
      withPoints: false
    }, options)

    @buildScoringEnds()
    @buildTotalsBlock()

  buildScoringEnds: () ->
    @scoringEnds = []
    for i in [1..@options.endCount]
      scoreData = @endScoresData[i - 1] ? {}
      scoringEnd = new XCard.ScoringEnd({
        cellCount: @options.cellCount,
        shotsPerEnd: @options.shotsPerEnd
        scores: scoreData['shots'] ? []
      })
      @scoringEnds.push scoringEnd

  buildTotalsBlock: () ->
    @totalsBlock = new XCard.ScoringRowTotals({
      withX: @options.withX,
      withGolds: @options.withGolds,
      withHits: @options.withHits,
      withPoints: @options.withPoints,
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
