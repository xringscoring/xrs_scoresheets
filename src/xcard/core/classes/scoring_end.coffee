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
      endInUse: true,
      cellCount: 3,
      scores: [],
      points: 0,
      config: null
    }, options)

    @endInUse = @options.endInUse
    @endTotalCell = null

    unless @options.config?
      throw "ScoringEnd requires DistanceConfig"

    @build()

  build: () ->
    @buildScoringCells()

    if @options.config.endsPerRow > 1
      @buildEndTotalCell()

  buildScoringCells: () ->
    @scoringCells = []
    for i in [1..@options.cellCount]
      unused = @isUnusedCell(i)
      scores = @options.scores[i - 1] ? {}
      @scoringCells.push new XCard.ScoreCell(scores, unused)

  buildEndTotalCell: () ->
    @endTotalCell = new XCard.EndTotalCell({
      config: @options.config
      scoringCells: @scoringCells
      totalScore: @totalScore()
      hasAtLeastOneScore: @hasAtLeastOneScore()
    })

  cells: () ->
    ary = @scoringCells.slice(0)
    ary.push( @endTotalCell ) if @endTotalCell?
    ary

  isUnusedCell: (cellNumber)->
    return true unless @endInUse
    return if cellNumber > @options.config.shotsPerEnd then true else false

  hasAtLeastOneScore: ()->
    @scoringCells.filter( (sc)->
      sc.scoreValue?
    ).length > 0

  totalHits: ()->
    @scoringCells.filter( (sc)->
      sc.score() > 0
    ).length

  totalGolds: ()->
    self = @
    @scoringCells.reduce( (accum, sc)->
      accum + if sc.score() is self.options.config.goldScore then 1 else 0
    , 0)

  totalScore: ()->
    @scoringCells.reduce( (accum, sc)->
      accum += sc.score()
      accum
    , 0)

  totalX: ()->
    @scoringCells.filter( (sc)->
      txt = sc.getTextContent()
      txt is 'x'
    ).length

  totalPoints: ()->
    @options.points
