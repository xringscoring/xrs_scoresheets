class window.AutoScoring
  constructor: ()->
    @distanceSpec = []
    @error = null

  sumArray: (ary)->
    return 0 if ary.length is 0
    ary.reduce (x, y) -> x + y

  adjustedScoresArray: (scoresArray, impliedMiss)->
    scoresArray.push(0) if impliedMiss
    scoresArray

  autoScoreV2: (shoot, score)->
    @error = null

    # Problematic: if scoring scheme changes per distance? Also, if multi-distance
    # target faces change, eg WA1440 50/30m...
    scoringScheme = shoot.scoringScheme().toArray()
    return null if !@validateScorePermissible(score, shoot.maxPossibleScore(), scoringScheme)

    allScores = @getArrowValuesForScoreAndTotalShots(score, shoot.maxShots(), scoringScheme)
    return null if !allScores

    # Set up our SvgTarget object using targetFace id, which may be updated as distances
    # change
    svgTarget = @getSvgTarget(shoot)
    targetFaceCount = svgTarget.getTargetFaceCount()

    sortedScores = @shuffleArray(allScores)

    sIndex = 0 # shotIndex, tracking each shot/end
    tIndex = 0 # targetFaceIndex, assigning each shot to sequential faces

    # BEGINNING OF SHOT LOOP
    for i in [0..(sortedScores.length - 1)]
      s = allScores[i]

      if shoot.canAddDistance()
        shoot.addDistance()
        # svgTarget = @getSvgTarget(shoot) # may change with distance?
        tIndex = 0
        sIndex = 0
      else
        if shoot.canAddEnd()
          shoot.addEnd()
          tIndex = 0
          sIndex = 0

      # Add in random 'x' if applicable
      identifier = @getShotIdentifier(shoot, s, scoringScheme)
      shotParams = svgTarget.getAutoPlotFromScore(identifier, "t#{tIndex}")

      # Augment shotParams with arrowId
      shotParams['arrowId'] = shoot.arrowIds()[ sIndex ]

      shot = new window.ShootShot(shotParams)
      shoot.addShot(shot)
      sIndex += 1
      tIndex = if tIndex is (targetFaceCount - 1) then 0 else tIndex + 1

    # END OF SHOT LOOP

    if shoot.totalScore() isnt @sumArray(sortedScores)
      @error = 'Error compiling scores'
      return null

    true

  # targetData can be null
  autoScore: (shoot, score, targetData = null)->
    @error = null
    autoPlot = targetData isnt null

    targetRound = shoot.targetRound
    return null if !@validateScorePermissible(score, targetRound.maxPossibleScore(), targetRound.scoring_scheme)

    # partitionedScores = @partitionScoreForTargetRound(score, targetRound)
    # return null if !@validateDistanceScoresAgainstSpec(partitionedScores, targetRound)

    allScores = @getArrowValuesForScoreAndTotalShots(score, targetRound.maxShots, targetRound.scoring_scheme)
    return null if !allScores

    # set up target rings for this distance
    if autoPlot
      tModule = window.ShootTargetData
      tData = tModule.load(shoot, targetData)
      tRings = tModule.buildTargetRings(tData, targetRound.scoring_scheme, shoot.xringEnabled())

    sIndex = 0

    sortedScores = @shuffleArray(allScores)

    for i in [0..(sortedScores.length - 1)]
      s = allScores[i]

      if !shoot.canAddShot()
        if shoot.canAddEnd()
          shoot.addEnd()

        if shoot.canAddDistance()
          shoot.addDistance()

        sIndex = 0

      # Add in random 'x' if applicable
      identifier = @getShotIdentifier(shoot, s, targetRound.scoring_scheme)

      shotParams = {
        score: s,
        arrowIdentifier: shoot.arrows[ sIndex ],
        arrowIndex: sIndex,
        cY: 0.0,
        cX: 0.0,
        is_x: (identifier is 'x').toString()
      }

      # TODO: refactor the '200' diam/radius requirement here, which equates to hardoded
      # values in window.ShootTargetData/TargetPlotterMobile
      if autoPlot
        targetRing = tRings[identifier]
        computedCoords = targetRing.getDistributedPointCoordinates()
        cX = (window.TargetPlotterMobile.getPositionFromCenter(computedCoords[0], 0, 1, 1)) / 200
        cY = (window.TargetPlotterMobile.getPositionFromCenter(computedCoords[1], 0, 1, 1)) / 200
        shotParams['cY'] = cY
        shotParams['cX'] = cX

      shot = new window.Shot(shotParams)
      shoot.addShot(shot)
      sIndex += 1

    if shoot.totalScore() isnt @sumArray(sortedScores)
      @error = 'Error compiling scores'
      return null

    true

  # Stack scores towards maxScores
  # Tends to create 2/3 scores only
  # TO DEPRECATE
  bubbleDistribution: (list, minScore, maxScore, step) ->
    for i in [1...list.length]
      for j in [0...list.length - i]
        if (list[j] - step) >= minScore
          for l in [(j+1)...list.length - 1]
            if ((list[l] - step) >= minScore) and ((list[l] + step) <= maxScore)
              list[j] -= step
              list[l] += step
            break if list[j] is minScore

    list


  divideToEvenNumber: (num)->
    return num if (num is 1) or (num is 0)
    2 * Math.round(Math.floor(num / 2) / 2)


  # The main routine which takes a total score (per distance, eg)
  # and partitions it amongst array of (total number of) shots
  # NOTE: this is a (very) brute force method:
  #
  # 1. Average scores across total shots
  # 2. Get remainder and add evenly to scores as per scheme
  # This results in no 'golds' for mid-range shoots, so then we have to
  # 3. Transform score to 'siphon' points from lower scores to the higher
  # 4. Have a cup of tea
  #
  # Need a modified unbounded knapsack method which returns best fit (and
  # number of items selected) for score while limited to max number of shots.
  #
  randomDistribution: (list, minScore, maxScore, step = 1)->
    result = {}

    total = 0
    scorePositions = []

    for s, i in list
      if s >= minScore
        scorePositions.push(i)
        total += (s - minScore)
        list[i] = minScore

    while total > 0
      randomPos = @getRandomNumber(scorePositions[0], scorePositions[ scorePositions.length-1])
      testValue = list[randomPos] + step
      if ((testValue <= maxScore) and (testValue >= minScore))
        list[randomPos] = testValue
        total -= step

    list

  getRandomNumber: (min, max)->
    Math.floor(Math.random() * (max - min + 1)) + min

  getArrowValuesForScoreAndTotalShots: (score, totalShots, scoringScheme)->
    self = @

    step = scoringScheme[0] - scoringScheme[1]

    # Handle cases where scoring is imperial and score is an odd
    # number - this implies a miss, so reduce loop by 1, reducing
    # array by 1, and add a 0 to array at the end
    impliedMiss = false

    if (score % 2) isnt 0
      if step is 2
        impliedMiss = true
        totalShots -= 1

    # Fill our array with the average score
    avgScore = score / totalShots

    if avgScore > scoringScheme[0]
      @error = 'Invalid score for this round'
      return false

    avgScore = Math.floor(avgScore)

    if avgScore isnt 0
      if step is 2
        if avgScore % 2 is 0
          avgScore -= 1
    else
      step = 1

    # adjust avgScore down by step if at maximum in order
    # to distribute golds more realistically - this has limits,
    # however, when at top end of scoring range, eg max golds for
    # 1300+ WA1440 is 40, regardless of min avg.
    if avgScore is scoringScheme[0]
      avgScore -= (step * 2)

    # Ensure avgScore is greater than minimum for this round
    # EG metric 5_zone or 6_zone scoring
    minScore = scoringScheme[ scoringScheme.length - 1 ]
    if avgScore < minScore
      avgScore = 0

    scores = @generatePopulatedArray(totalShots, avgScore)
    remainder = score - @sumArray(scores)

    if remainder is score
      scores = @whenAverageScoreIsZero(scores, score, scoringScheme)
      return scores.reverse()

    # Stack max scores left-ward
    if remainder > 0
      for i in [0..(totalShots - 1)]
        if scores[i] < scoringScheme[0]
          while remainder > 0
            remainder -= step
            scores[i] += step
            break if (scores[i] is scoringScheme[0])
          break if remainder is 0
        i = 0 if i is (totalShots - 1)

    if impliedMiss
      scores.push(0)

    return @siphonScores(scores, scoringScheme)

  # This would be better handled by Array.fill()
  # but browser compat may be sketchy
  generatePopulatedArray: (size, defaultValue)->
    ary = new Array(size)
    for ele, i in ary
      ary[i] = defaultValue
    ary

  # Note distances are reversed in order to favour closer
  # distances
  getScoreDistribution: (score, targetRound)->
    distanceSpec = @getTargetRoundSpec(targetRound)
    @partitionDistanceScores(score, distanceSpec)

  # Enables us to randomly set an x for max scores if appropriate
  getShotIdentifier: (s, score, scoringScheme)->
    return score if !s.xringEnabled()
    return score if (parseInt(scoringScheme[0]) isnt 10)
    return score if score isnt 10

    return if @getRandomBoolean() then 'x' else score

  getRandomBoolean: ()->
    # Boolean(Math.round(Math.random()))
    Math.random() >= 0.5

  getSvgTarget: (shoot)->
    scoringSchemeId = shoot.scoringSchemeId()
    scoringScheme   = new window.ScoringScheme(scoringSchemeId, shoot.usingX())
    selector        = shoot.targetFace().svgSelector()
    svgTarget       = new window.SvgTarget(selector, { scoringScheme: scoringScheme })
    svgTarget

  getTargetRoundSpec: (targetRound)->
    distanceSpec = []
    distances = targetRound.roundDistances().slice().reverse()

    for d in distances
      distanceSpec.push(d.maxPossibleScore())

    distanceSpec

  # Average score may not be on scheme number line, so decrement
  # by 1 until it fits
  getValidAverageScore: (score, totalShots, scoringScheme)->
    avg = Math.floor(score / totalShots)

    while avg > 0
      break if scoringScheme.indexOf(avg) isnt -1
      avg -= 1

    return avg

  partitionScoreForTargetRound: (score, targetRound)->
    self = @

    # distances are reversed during score distribution, so we need to flip them
    distanceDistribution = @getScoreDistribution(score, targetRound).reverse()
    roundDistances = targetRound.roundDistances()
    distanceScores = []

    for sc, i in distanceDistribution
      d = roundDistances[i]
      scores = @getArrowValuesForScoreAndTotalShots(sc, d.totalShots(), d.scoring())
      distanceScores[i] = self.shuffleArray(scores)

    distanceScores

  partitionDistanceScores: (score, distanceSpec)->
    # array = new Array(distanceSpec.length).fill(0)
    array = @generatePopulatedArray(distanceSpec.length, 0)
    i = 0

    while score > 0
      if i is distanceSpec.length then i = 0

      if array[i] < distanceSpec[i]
        array[i] += 1
        score -= 1

      i += 1

    array

  scoringSchemeIsImperial: (scoringScheme)->
    (scoringScheme[0] is 9) and (scoringScheme[scoringScheme.length - 1] is 1)

  siphonScores: (scores, scheme)->
    step = scheme[0] - scheme[1]
    minScore = scheme[scheme.length - 1]
    maxScore = scheme[0]

    sortedScores = @sortNumerically(scores.slice(0)).reverse()
    @sortNumerically(@randomDistribution(sortedScores, minScore, maxScore, step))

  sortNumerically: (list)->
    sorter =(a, b)->
      return -1 if a < b
      return 1 if a > b

    list.sort(sorter)

  # Knuth shuffle - modularize this?
  shuffleArray: (a)->
    i = a.length
    while --i > 0
      j = ~~(Math.random() * (i + 1))
      t = a[j]
      a[j] = a[i]
      a[i] = t

    a

  whenAverageScoreIsZero: (scores, score, scoringScheme)->
    # Use unbounded knapsack solution
    k = window.Knapsack
    result = k.distribution(score, scoringScheme)

    for s, i in result
      scores[i] = s

    scores

  validateScorePermissible: (rawScore, maxPoss, scoringScheme)->
    score = rawScore + 0
    minScore = scoringScheme[ scoringScheme.length - 1]

    @error = null

    msg = "Score must be between #{minScore} and #{maxPoss}"

    if (isNaN(score) or (score > maxPoss))
      @error = msg

    @validMinimumScore(score, minScore)

    @error is null

  validateDistanceScoresAgainstSpec: (partitionedScores, targetRound)->
    distanceSpec = @getTargetRoundSpec(targetRound)

    for d, i in partitionedScores
      if ((d > distanceSpec[i]) or (d < distanceSpec[i]))
        @error = 'Error splitting scores between distances'
        break

    @error is null

  validMinimumScore: (score, minScore)->
    return true if score is minScore

    threshold = minScore

    # Handle abbreviated scoring (eg Metric 5 zones)
    if minScore is 6
      threshold = (minScore * 2) - 1 # score of 11 is invalid

    # Single arrow value!
    if score < minScore
      @error = "Score should be minimum of #{minScore}"
      return false

    if score is threshold
      @error = "#{score} is an invalid score for this round"
      return false

    true
