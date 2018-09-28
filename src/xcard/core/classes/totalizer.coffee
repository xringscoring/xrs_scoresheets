class XCard.Totalizer

  constructor: (config = {}) ->
    @withGolds = config.withGolds ? false
    @withX = config.withX ? false
    @withPoints = config.recurveMatch ? false
    @withHits = !@withPoints

    @totalHits = @totalScore = @totalPoints = @totalGolds = @totalX = 0
