class XCard.Totalizer

  constructor: (options = {}) ->
    # unless options.config?
    #   throw "Totalizer requires DistanceConfig"

    @totalHits = @totalScore = @totalPoints = @totalGolds = @totalX = 0

  # totalHits: ()->
  #   # @totalHits
  #   8

  # totalGolds: ()->
  #   @totalGolds
  #
  # totalX: ()->
  #   @totalX

  # runningTotal: ()->
  #   @totalScore
  #
  # runningTotalPoints: ()->
  #   @totalPoints
  #
  # totalPoints: ()->
  #   @runningTotalPoints()

  # totalScore: ()->
  #   @runningTotal()
