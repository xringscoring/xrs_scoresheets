class XCard.ScoreDataAdapter

  constructor: (@scoreData = {})->
    @parseData()

  parseData: ()->
    @distances = @scoreData['distances'] ? []

  distances: ()->
    @distances
