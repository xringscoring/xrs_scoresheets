#
# Represents a full scoring row (comprising 1/2 scoringEnd groups)
#
# endScoresData should be array of literal objects containing 'shots' array
#

class XCard.ScoringRow extends XCard.BlockElement

  constructor: (options = {}, @endScoresData = []) ->
    opts = Object.assign({
      rowIndex: 0
      config: null
      totals: null
    }, options)

    super(opts)

    @buildScoringEnds()
    @buildTotalsBlock()

  buildScoringEnds: () ->
    @scoringEnds = []
    for i in [1..@config.endsPerRow]
      scoreData = @endScoresData[i - 1] ? {}
      scores = @orderedScores(scoreData['shots'] ? [])

      scoringEnd = new XCard.ScoringEnd({
        endInUse: @ensureEndInUse(i),
        config: @config,
        cellCount: @config.cellsPerEnd,
        scores: scores,
        points: @pointsForRow(scoreData)
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

  orderedScores: (scores = [])->
    scores.slice(0).map((s)->
      scr = parseInt(s.score ? 0, 10)
      txt = s.text ? ''
      s._tempScore = if txt.toString().match(/x/i)? then 11 else scr
      s
    ).sort((a, b)->
      b._tempScore - a._tempScore
    )

  # Zero points should not show up (if matchResult is -1, it means
  # the end has not been scored, so no scoring cells should be asserted yet)
  pointsForRow: (scoreData)->
    points = parseInt(scoreData['matchEndResult'] ? 0, 10)
    return 0 if points is -1
    points

  toHtml: ()->
    element = new XCard.BasicElement({ className: 'scoring-row' }, 'tr').toHtml()
    
    for pCell in @paddingCells
      element.appendChild(pCell.toHtml())

    for se in @scoringEnds
      for sc in se.cells()
        element.appendChild(sc.toHtml())

    for rt in @totalsBlock.cells
      element.appendChild(rt.toHtml())

    element
