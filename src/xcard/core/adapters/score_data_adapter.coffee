class XCard.ScoreDataAdapter

  constructor: (@scoreData = {})->
    @parseData()

  parseData: ()->
    # If scoreData.isMatch? and distance count > 1, remaining distances
    # are tie-breakers, and ends need to be added to distances[1].distanceEnds
    @distances = @parseDistanceData()

  distances: ()->
    @distances

  parseDistanceData: ()->
    return [] unless @scoreData['distances']?
    distances = @scoreData['distances']
    distanceCount = distances.length

    return distances unless @shootIsMatch()

    if distanceCount > 2
      finalDistanceEnds = distances[1]['distanceEnds'].slice(0)

      for dIndex in [2...distanceCount]
        dEnds = distances[dIndex]['distanceEnds']
        finalDistanceEnds = finalDistanceEnds.concat(dEnds)

      distances[1]['distanceEnds'] = finalDistanceEnds

    return distances

  shootIsMatch: ()->
    if @scoreData['targetRoundShortName']?
      return @scoreData['targetRoundShortName'].match(/match/)

    false
