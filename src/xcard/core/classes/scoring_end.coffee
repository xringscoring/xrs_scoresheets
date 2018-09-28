# Represents a single end of scores, and associated EndTotal
# Expressed as an array of (table) cells, eg 'td'
# Args: scores should be an array of literal objects in following format:
# score = {
#   score: 9,
#   isGold: true,
#   isX: false,
#   text: null
# }
#
# or
#
# score = {
#   score: 10,
#   isGold: true,
#   isX: true,
#   text: 'x'
# }

class XCard.ScoringEnd

  # shotsPerEnd/cellCount determines unused cells
  constructor: (options = {}) ->
    @options = Object.assign({
      cellCount: 3,
      scores: [],
      shotsPerEnd: 3
    }, options)

    @build()

  build: () ->
    @buildScoringCells()
    @buildEndTotalCell()

  buildScoringCells: () ->
    @scoringCells = []
    for i in [1..@options.cellCount]
      unused = if i > @options.shotsPerEnd then true else false
      scores = @options.scores[i - 1] ? {}
      @scoringCells.push new XCard.ScoreCell(scores, unused)

  buildEndTotalCell: () ->
    @endTotalCell = new XCard.EndTotalCell({
      scoringCells: @scoringCells
    })

  cells: () ->
    ary = @scoringCells.slice(0)
    ary.push( @endTotalCell )
    ary

  totalHits: ()->
    @scoringCells.filter( (sc)->
      sc.score() > 0
    ).length

  totalScore: ()->
    @endTotalCell.totalScore()
